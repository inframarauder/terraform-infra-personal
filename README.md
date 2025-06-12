# terraform-infra-personal

Terraform code for all the infrastructure I need in my personal projects/experiments.

# acm-cloudflare
Generates an ACM certificate for a domain whose DNS records are managed on Cloudflare

# ec2-tailscale-exit-node
Deploys an EC2 instance as a [tailscale exit-node](https://tailscale.com/kb/1103/exit-nodes). Used to create my personal VPN server.

# eks-ai
Creates an EKS Cluster for running AI Workloads. Uses EKS Auto Mode with custom node pools to support CPU and GPU nodes.
Steps to create - 
 - `cd eks-ai`
 - `terraform init`
 - `terraform apply -auto-approve`
 - `aws eks update-kubeconfig --name <cluster-name>`
 - `kubectl apply -f k8s-manifests/`