variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with permissions to manage DNS records"
}

variable "domain_name" {
  type        = string
  description = "Domain managed by Cloudflare"
}
