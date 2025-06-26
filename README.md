# terraform-infra-personal

Terraform code for all the infrastructure I need in my personal projects/experiments.

# acm-cloudflare
Generates an ACM certificate for a domain whose DNS records are managed on Cloudflare

# ec2-tailscale-exit-node
Deploys an EC2 instance as a [tailscale exit-node](https://tailscale.com/kb/1103/exit-nodes). Used to create my personal VPN server.

# eks-demo-cluster
Creates - 
 - a VPC with the required tags for ALB Ingress Controller to work
 - an EKS cluster with some default nodes