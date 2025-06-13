terraform {
  backend "s3" {
    bucket       = "inframarauder-tf-state"
    key          = "ai-infra/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
