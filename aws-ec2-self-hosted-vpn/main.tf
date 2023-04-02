# fetch ubuntu LTS image
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
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

# create cloud init script to setup tailscale exit node
data "template_file" "script" {
  template = file("${path.module}/files/user-data.tpl")

  vars = {
    tailscale_authkey = "${var.tailscale_authkey}"
  }
}

data "template_cloudinit_config" "user_data" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "user-data.sh"
    content_type = "text/cloud-config"
    content      = data.template_file.script.rendered
  }
}


# create ec2 instance 
resource "aws_instance" "vpn" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = local.ssh_key_pair_name
  vpc_security_group_ids      = [aws_security_group.vpn.id]
  associate_public_ip_address = true
  user_data_base64            = data.template_cloudinit_config.user_data.rendered

  tags = {
    Name = local.vpn_instance_name
  }
}
