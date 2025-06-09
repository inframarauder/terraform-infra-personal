terraform {
  backend "s3" {
    bucket       = "inframarauder-tf-state"
    key          = "eks-cluster-ai/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
