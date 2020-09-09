locals {
  cluster_pg_name  = "${lower(var.cluster_name)}-aurora-postgresql11-7-cluster"
  instance_pg_name = "${lower(var.cluster_name)}-aurora-postgresql11-7-instance"
}
