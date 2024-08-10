terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  cloud {
    organization = "terraform-infra-personal-org"
    workspaces {
      name = "ec2-tailscale-exit-node"
    }
  }
}

provider "aws" {
  region = var.region
}
