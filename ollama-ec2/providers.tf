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
      name = "ollama-ec2"
    }
  }
}

provider "aws" {
  region = var.region
}
