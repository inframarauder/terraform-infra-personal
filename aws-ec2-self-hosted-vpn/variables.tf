variable "vpn_region" {
  type        = string
  description = "The AWS region to deploy the VPN server to"
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the VPN server"
  default     = "t4g.nano"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID to use for the VPN server"
  default     = "ami-0a5dcff6fb7af3fc9" # Ubuntu 22.04 LTS arm64
}
