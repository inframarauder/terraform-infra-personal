output "tailscale_authkey_exit_node" {
  value     = tailscale_tailnet_key.exit_node.key
  sensitive = true
}
