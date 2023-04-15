terraform {
  required_version = ">= 1.0.0"
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.13.6"
    }
  }
  backend "s3" {
    bucket         = "terraform-remote-state-subhasis020299"
    key            = "tailscale/terraform.tfstate"
    dynamodb_table = "terraform-remote-state-lock-table"
    region         = "ap-south-1"
    encrypt        = true
  }
}

provider "tailscale" {
  api_key = var.tailscale_api_key
  tailnet = var.tailnet_name
}
