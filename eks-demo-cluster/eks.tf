# Create an EKS cluster with all the necessary add-ons and node groups
module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                             = var.cluster_name
  cluster_version                          = var.cluster_version
  subnet_ids                               = module.vpc.private_subnets # place nodes in private subnets
  vpc_id                                   = module.vpc.vpc_id
  cluster_endpoint_public_access           = true
  enable_irsa                              = true
  enable_cluster_creator_admin_permissions = true
  node_iam_role_name                       = "eks-demo-cluster-node-role"

  cluster_addons = {
    vpc-cni = {}
    coredns = {}
  }

  eks_managed_node_group_defaults = {
    instance_types = var.node_instance_types
    min_size       = var.node_group_min_size
    desired_size   = var.node_group_desired_size
    max_size       = var.node_group_max_size
  }

  depends_on = [
    module.vpc
  ]
}

# update kubeconfig
resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name} --alias ${var.cluster_name}"
  }

  depends_on = [module.eks_cluster]
}
