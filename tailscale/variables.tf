variable "tailscale_api_key" {
  type        = string
  description = "The API key for the Tailscale account - must be rotated every 90 days"
  sensitive   = true
}

variable "tailnet_name" {
  type        = string
  description = "The name of the Tailscale tailnet to join"
  default     = "subhasisdas125@gmail.com"
}
