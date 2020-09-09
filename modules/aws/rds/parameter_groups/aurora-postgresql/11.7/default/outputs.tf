output "cluster_parameter_group_arn" {
  description = "The ARN of the db cluster parameter group"
  value       = aws_rds_cluster_parameter_group.default.arn
}

output "instance_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = aws_db_parameter_group.default.arn
}

output "cluster_parameter_group_name" {
  description = "The name of the db cluster parameter group"
  value       = aws_rds_cluster_parameter_group.default.name
}

output "instance_parameter_group_name" {
  description = "The name of the db parameter group"
  value       = aws_db_parameter_group.default.name
}
