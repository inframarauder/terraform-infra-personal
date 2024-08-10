output "ec2_public_dns" {
  value = aws_instance.vpn.public_dns
}

output "ec2_public_ip" {
  value = aws_instance.vpn.public_ip
}
  
