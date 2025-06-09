# fetch VPC and subnet IDs
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Create an EKS cluster with two node groups: one for CPU workloads and one for GPU workloads
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version
  subnet_ids      = data.aws_subnets.subnets.ids
  vpc_id          = data.aws_vpc.default.id

  enable_irsa = true

  eks_managed_node_groups = {
    cpu_nodes = {
      min_size       = 1
      desired_size   = 2
      instance_types = ["t3.medium"]
      labels = {
        "workload-type" = "cpu"
      }
      taints = [{
        key    = "workload-type"
        value  = "cpu"
        effect = "NO_SCHEDULE"
      }]
      ami_type = "AL2_x86_64"
    }

    gpu_nodes = {
      min_size       = 0
      desired_size   = 1
      instance_types = ["g5.xlarge"]
      labels = {
        "workload-type" = "gpu"
      }
      taints = [{
        key    = "workload-type"
        value  = "gpu"
        effect = "NO_SCHEDULE"
      }]
      ami_type = "AL2_x86_64_GPU"
    }
  }
}

# install the AWS Load Balancer Controller
module "alb_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name                              = "alb-ingress-controller"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}
resource "helm_release" "aws_lb_controller" {
  name             = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  namespace        = "kube-system"
  create_namespace = false

  set {
    name  = "clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "region"
    value = var.aws_region
  }

  set {
    name  = "vpcId"
    value = data.aws_vpc.default.id
  }

  depends_on = [module.alb_irsa]
}
