locals {
  node_class_yml = templatefile("${path.module}/k8s-manifests/node-class.yml.tpl", {
    node_role_arn          = module.eks.node_iam_role_arn
    node_class_name        = "cpu-node-class"
    subnet_ids             = data.aws_subnets.subnets.ids
    security_group_ids     = [module.eks.cluster_security_group_id]
    ephemeral_storage_size = "16Gi"
  })

  node_pool_yml = templatefile("${path.module}/k8s-manifests/node-pool.yml.tpl", {
    node_class_name    = "cpu-node-class"
    node_pool_name     = "cpu-node-pool"
    node_role_arn      = module.eks.node_iam_role_arn
    instance_families  = ["t3"]
    instance_sizes     = ["medium", "large"]
    availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
    capacity_types     = ["spot"]
  })
}
