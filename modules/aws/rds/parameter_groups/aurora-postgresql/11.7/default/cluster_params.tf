# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/AuroraPostgreSQL.Reference.html
resource "aws_rds_cluster_parameter_group" "default" {
  name        = local.cluster_pg_name
  family      = "aurora-postgresql11"
  description = "Aurora postgres11 cluster-level parameter group for ${local.cluster_name} cluster"

  parameter {
    name  = "autovacuum"
    value = var.autovacuum
  }

  parameter {
    name  = "autovacuum_analyze_scale_factor"
    value = var.autovacuum_analyze_scale_factor
  }

  parameter {
    name  = "autovacuum_vacuum_scale_factor"
    value = var.autovacuum_vacuum_scale_factor
  }

  parameter {
    name  = "log_autovacuum_min_duration"
    value = var.log_autovacuum_min_duration
  }

  parameter {
    name  = "rds.force_autovacuum_logging_level"
    value = var.rds_force_autovacuum_logging_level
  }

  parameter {
    name         = "rds.logical_replication"
    value        = var.rds_logical_replication
    apply_method = "pending-reboot"
  }

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}
