output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "subnet_ids" {
  description = "Application subnet IDs"
  value       = aws_subnet.app[*].id
}