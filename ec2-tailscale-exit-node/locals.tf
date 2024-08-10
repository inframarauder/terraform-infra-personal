locals {
  ssh_key_pair_name = "ssh-${var.region}"
  vpn_instance_name = "tailscale-exit-node-${var.region}"
}
