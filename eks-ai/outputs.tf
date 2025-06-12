# These outputs are needed to be set in the `k8s-manifests` files:
output "node_iam_role_arn" {
  value       = module.eks.node_iam_role_arn
  description = "ARN of the EKS node IAM role"
}

output "subnet_ids" {
  value       = data.aws_subnets.subnets.ids
  description = "List of subnet IDs in the default VPC"
}

output "security_group_ids" {
  value       = module.eks.cluster_security_group_id
  description = "Security group ID for the EKS cluster"
}
