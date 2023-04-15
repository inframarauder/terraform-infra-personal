variable "region" {
  type        = string
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the VPN server"
  default     = "t4g.nano"
}

variable "tailscale_authkey" {
  type        = string
  description = "The tailscale authkey to use for the VPN server"
}
