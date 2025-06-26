terraform {
  backend "s3" {
    bucket       = "inframarauder-tf-state"
    key          = "eks-demo-cluster/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
