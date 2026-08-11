variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "devops-ec2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
  default     = "ami-0f918f7e67a3323f0"
}

variable "key_name" {
  description = "AWS EC2 Key Pair"
  type        = string
  default     = "three-tier-key"
}