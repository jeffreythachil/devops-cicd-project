output "instance_profile_name" {
  value = data.aws_iam_instance_profile.ec2_profile.name
}