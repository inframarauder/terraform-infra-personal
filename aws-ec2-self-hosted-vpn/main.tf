# fetch default VPC in region
data "aws_vpc" "default" {
  default = true
}

# create a security group for the VPN server to allow SSH only
resource "aws_security_group" "vpn" {
  name        = "vpn-sg"
  description = "Allow SSH traffic"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpn.id
}

resource "aws_security_group_rule" "all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpn.id
}

# fetch tailscale exit node authkey from aws secrets manager
data "aws_secretsmanager_secret" "secrets" {
  provider = aws.secretsmanager
  name     = "infra-secrets-personal"
}

data "aws_secretsmanager_secret_version" "secrets" {
  provider  = aws.secretsmanager
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

# create ec2 instance 
resource "aws_instance" "vpn" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = local.ssh_key_pair_name
  vpc_security_group_ids      = [aws_security_group.vpn.id]
  associate_public_ip_address = true
  user_data_base64 = base64encode("${templatefile("${path.module}/files/user-data.sh", {
    hostname          = local.vpn_instance_name
    tailscale_authkey = local.tailscale_exit_node_authkey
  })}")

  tags = {
    Name = local.vpn_instance_name
  }
}
