terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "auto-destroy" = "true"
      "Terraform"    = "true"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = module.ai_eks_cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.ai_eks_cluster.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
      command     = "aws"
    }
  }
}
