# Tailnet acls
resource "tailscale_acl" "acl" {
  acl = file("${path.module}/files/acl.json")
}
