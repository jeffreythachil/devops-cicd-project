data "aws_iam_role" "ec2_role" {
  name = "EC2-ECR-ReadOnly-Role"
}

data "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2-ECR-ReadOnly-Role"
}