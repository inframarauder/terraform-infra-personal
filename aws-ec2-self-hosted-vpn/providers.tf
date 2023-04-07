terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-remote-state-20230329190948520800000001"
    key            = "aws-ec2-self-hosted-vpn/terraform.tfstate"
    dynamodb_table = "terraform-remote-state-lock-table"
    region         = "ap-south-1"
    encrypt        = true
  }
}

provider "aws" {
  region = var.vpn_region
}

# provider alias for aws secrets manager
provider "aws" {
  alias  = "secretsmanager"
  region = "ap-south-1"
}
