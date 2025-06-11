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

  cluster_name                             = var.eks_cluster_name
  cluster_version                          = var.eks_cluster_version
  subnet_ids                               = data.aws_subnets.subnets.ids
  vpc_id                                   = data.aws_vpc.default.id
  cluster_endpoint_public_access           = true
  enable_irsa                              = true
  enable_cluster_creator_admin_permissions = true

  # EKS Auto Mode - built in node pools
  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }
}

# Custom node-pools
resource "null_resource" "kubectl_apply" {
  provisioner "local-exec" {
    # update kubeconfig and apply node class and node pool manifests
    interpreter = ["bash", "-c"]
    command     = <<EOT
      aws eks update-kubeconfig --name ${var.eks_cluster_name} --region ${var.aws_region}
      echo "${local.node_class_yml}" | kubectl apply -f -
      echo "${local.node_pool_yml}" | kubectl apply -f -
    EOT
  }

  depends_on = [module.eks]
}

# EKS Access Policy Association
# This associates the EKS Auto Node Policy with the node IAM role
resource "aws_eks_access_policy_association" "this" {
  cluster_name  = var.eks_cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAutoNodePolicy"
  principal_arn = module.eks.node_iam_role_arn

  access_scope {
    type = "cluster"
  }
}
