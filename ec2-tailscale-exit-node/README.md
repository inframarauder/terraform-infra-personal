# ec2-tailscale-exit-node

Spins up an EC2 instance with Tailscale installed and configured as an exit node. This lets the instance to be used as a VPN server for the region specified. The EC2 instance is created in the default VPC and placed in a public subnet of the region specified.

## Steps to run locally

- Create a `terraform.tfvars` file inside the current directory and fill the variables with the values you want to use. Refer to `variables.tf` to see all variables, their descriptions, and default values.

- Run `terraform init` to initialize the Terraform project.
- Run `terraform plan` to see what resources will be created.
- Run `terraform apply -auto-approve` to create the resources.
