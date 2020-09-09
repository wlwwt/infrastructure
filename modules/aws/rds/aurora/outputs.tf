output "cluster_arn" {
  value = aws_rds_cluster.main.arn
}

output "cluster_identifier" {
  description = "Identifier for the RDS Cluster"
  value       = aws_rds_cluster.main.cluster_identifier
}

output "instance_identifiers" {
  description = "Identifiers for the RDS Instances"
  value       = aws_rds_cluster_instance.main.*.identifier
}

output "writer_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = aws_rds_cluster.main.endpoint
}

output "reader_endpoint" {
  description = "A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas"
  value       = aws_rds_cluster.main.reader_endpoint
}

output "all_endpoints" {
  description = "List of all DB instances endpoints running in the cluster"
  value       = [aws_rds_cluster_instance.main.*.endpoint]
}

output "db_port" {
  value = var.port
}

output "root_credentials" {
  value     = "${aws_rds_cluster.main.master_username}:${aws_rds_cluster.main.master_password}"
  sensitive = true
}
