output "vpc_id" {
  value = module.ai_vpc.vpc_id
}

output "eks_cluster_endpoint" {
  value = module.ai_eks.cluster_endpoint
}
