variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "ap-south-1"
}


variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  default     = "eks-ai-cluster"
}

variable "eks_cluster_version" {
  type        = string
  description = "Version of the EKS cluster"
  default     = "1.32"
}
