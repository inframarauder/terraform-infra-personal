variable "region" {
  type        = string
  description = "The AWS region to deploy to"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the VPN server"
}

variable "vol_size" {
  type        = number
  description = "Size of the EBS volume in GiB"
}
