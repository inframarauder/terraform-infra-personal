terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.9.0"

    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.5.0"
    }

  }
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token

}
