module "vpc" {
  source = "./modules/vpc"

  vpc_cidr          = "10.0.0.0/16"
  subnet_cidr       = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}

module "ec2" {
  source = "./modules/ec2"

  instance_name = var.instance_name
  instance_type = var.instance_type
  ami_id        = var.ami_id
  key_name      = var.key_name

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id

  user_data = file("${path.module}/scripts/user_data.sh")
}