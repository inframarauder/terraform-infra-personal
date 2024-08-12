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

# fetch vpc
data "aws_vpc" "default" {
  default = true
}


# security group
resource "aws_security_group" "ollama" {
  name        = "ollama-sg"
  description = "Security group rules for the Ollama EC2 deployment"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "ollama_ingress" {
  for_each = local.firewall_rules

  type              = "ingress"
  protocol          = "tcp"
  from_port         = each.key
  to_port           = each.key
  cidr_blocks       = each.value
  security_group_id = aws_security_group.ollama.id
}

resource "aws_security_group_rule" "ollama_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ollama.id
}

resource "aws_instance" "ollama" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  availability_zone           = "${var.region}a"
  key_name                    = local.ssh_key_pair_name
  vpc_security_group_ids      = [aws_security_group.ollama.id]
  associate_public_ip_address = true

  user_data_base64 = base64encode("${templatefile("${path.module}/user-data/setup.sh", {
    hostname     = "ollama"
    ssh_username = "ubuntu"
  })}")

  tags = {
    Name = "ollama"
  }
}

# adding a volume
resource "aws_ebs_volume" "ollama" {
  availability_zone = "${var.region}a"
  size              = var.vol_size
}

resource "aws_volume_attachment" "ollama" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ollama.id
  instance_id = aws_instance.ollama.id
}
