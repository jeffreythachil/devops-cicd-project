variable "project_name" {
  description = "Project name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "EC2 security group ID"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "instance_profile_name" {
  description = "EC2 instance profile name"
  type        = string
}

variable "desired_capacity" {
  description = "Desired instance count"
  type        = number
}

variable "min_size" {
  description = "Minimum instance count"
  type        = number
}

variable "max_size" {
  description = "Maximum instance count"
  type        = number
}

variable "user_data" {
  description = "EC2 bootstrap script"
  type        = string
}