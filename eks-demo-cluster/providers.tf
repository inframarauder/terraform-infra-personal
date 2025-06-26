terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
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
