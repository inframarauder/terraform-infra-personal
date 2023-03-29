# Tailnet acls
resource "tailscale_acl" "acl" {
  acl = file("${path.module}/files/acl.json")
}

# Tailscale authkeys - (for use with tailscale up --authkey)
resource "tailscale_tailnet_key" "exit_node" {
  reusable      = true
  ephemeral     = true
  preauthorized = true
  tags          = toset(["tag:exit-node", "tag:aws-ec2"])
}
