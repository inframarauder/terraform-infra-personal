terraform {
  required_version = ">= 1.0.0"
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.13.7"
    }
  }
  backend "s3" {
    bucket         = "terraform-remote-state-subhasis020299"
    key            = "tailscale/terraform.tfstate"
    dynamodb_table = "terraform-remote-state-subhasis020299-lock-table"
    region         = "ap-south-1"
    encrypt        = true
  }
}

provider "tailscale" {
  tailnet = "subhasisdas125@gmail.com"
}
