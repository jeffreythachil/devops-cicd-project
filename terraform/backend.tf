terraform {
  backend "s3" {
    bucket       = "devops-cicd-terraform-state-163265929593-ap-south-1-an"
    key          = "terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}