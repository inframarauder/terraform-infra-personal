locals {
  ssh_key_pair_name           = "ssh-${var.region}"
  vpn_instance_name           = "tailscale-exit-node-${var.region}"
  tailscale_exit_node_authkey = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["TAILSCALE_EXIT_NODE_AUTHKEY"]
}
