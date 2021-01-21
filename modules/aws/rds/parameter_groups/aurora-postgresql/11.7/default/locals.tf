locals {
  cluster_name     = "db-${var.app_name}-${var.environment}"
  cluster_pg_name  = "${lower(local.cluster_name)}-aurora-postgresql11-7-cluster"
  instance_pg_name = "${lower(local.cluster_name)}-aurora-postgresql11-7-instance"
}
