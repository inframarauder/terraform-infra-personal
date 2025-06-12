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

# Create an EKS cluster in auto mode with built-in node pools
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                             = var.eks_cluster_name
  cluster_version                          = var.eks_cluster_version
  subnet_ids                               = data.aws_subnets.subnets.ids
  vpc_id                                   = data.aws_vpc.default.id
  cluster_endpoint_public_access           = true
  enable_irsa                              = true
  enable_cluster_creator_admin_permissions = true
  node_iam_role_name                       = "eks-ai-node-role"

  # EKS Auto Mode - built in node pools
  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }
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

  depends_on = [module.eks]
}
