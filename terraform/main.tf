module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  subnet_cidrs       = var.subnet_cidrs
}

module "ecr" {
  source = "./modules/ecr"

  repository_name = var.ecr_repository_name
}

module "iam" {
  source = "./modules/iam"

  project_name       = var.project_name
  ecr_repository_arn = module.ecr.repository_arn
}

module "alb" {
  source = "./modules/alb"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.subnet_ids
  app_port          = var.app_port
  health_check_path = var.health_check_path
}

module "asg" {
  source = "./modules/asg"

  project_name          = var.project_name
  instance_type         = var.instance_type
  subnet_ids            = module.vpc.subnet_ids
  security_group_id     = module.alb.ec2_security_group_id
  target_group_arn      = module.alb.target_group_arn
  instance_profile_name = module.iam.instance_profile_name

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size
  user_data        = file("${path.module}/scripts/user_data.sh")
}

moved {
  from = module.vpc.aws_internet_gateway.igw
  to   = module.vpc.aws_internet_gateway.main
}

moved {
  from = module.vpc.aws_route_table.public_rt
  to   = module.vpc.aws_route_table.app
}

moved {
  from = module.vpc.aws_route_table_association.public_assoc
  to   = module.vpc.aws_route_table_association.app[0]
}

moved {
  from = module.vpc.aws_subnet.public_subnet
  to   = module.vpc.aws_subnet.app[0]
}