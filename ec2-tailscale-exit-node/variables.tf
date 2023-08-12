variable "aws_access_key_id" {
  type        = string
  description = "The AWS_ACCESS_KEY_ID for the terraform user"
}

variable "aws_secret_access_key" {
  type        = string
  description = "The AWS_SECRET_ACCESS_KEY for the terraform user"
}

variable "region" {
  type        = string
  description = "The AWS region to deploy to"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the VPN server"
}

variable "tailscale_authkey" {
  type        = string
  description = "The tailscale authkey to use for the VPN server"
}
