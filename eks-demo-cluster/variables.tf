variable "aws_region" {
  type        = string
  description = "The region to create AWS Resources in"
  default     = "ap-south-1"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
  default     = "eks-demo-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR Block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnets"
  default     = "10.0.0.1/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnets"
  default     = "10.0.1.0/24"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS Cluster"
  default     = "eks-demo-cluster"
}

variable "cluster_version" {
  type        = string
  description = "The version of kubernetes to run on the cluster"
  default     = "1.33"
}

variable "node_instance_types" {
  type        = list(string)
  description = "The instance types allowed in the node group"
  default     = ["t3a.small"]
}

variable "node_group_min_size" {
  type        = number
  description = "The min no. of nodes in the node group"
  default     = 1
}

variable "node_group_desired_size" {
  type        = number
  description = "The desired no. of nodes in the node group"
  default     = 3
}

variable "node_group_max_size" {
  type        = number
  description = "The max no. of nodes in the node group"
  default     = 10
}
