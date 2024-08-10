# fetch ubuntu 22.04 LTS image
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

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

# create ec2 instance 
resource "aws_instance" "vpn" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = local.ssh_key_pair_name
  vpc_security_group_ids      = [aws_security_group.vpn.id]
  associate_public_ip_address = true
  user_data_base64 = base64encode("${templatefile("${path.module}/user-data/setup.sh", {
    hostname          = local.vpn_instance_name
    tailscale_authkey = var.tailscale_authkey
  })}")

  tags = {
    Name = local.vpn_instance_name
  }
}
