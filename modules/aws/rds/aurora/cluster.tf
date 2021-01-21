resource "aws_rds_cluster" "main" {
  lifecycle {
    ignore_changes = [
      master_password,
      snapshot_identifier,

      # Waiting for cluster role association resource
      iam_roles,
    ]
  }

  cluster_identifier              = local.cluster_name
  engine                          = var.engine
  engine_version                  = var.engine_version
  master_username                 = var.master_username
  master_password                 = local.master_password
  port                            = var.port
  vpc_security_group_ids          = var.security_group_ids
  db_subnet_group_name            = var.db_subnet_group_name
  db_cluster_parameter_group_name = var.cluster_parameter_group_name
  apply_immediately               = var.apply_immediately
  snapshot_identifier             = var.snapshot_identifier
  final_snapshot_identifier       = "${local.cluster_name}-final-snapshot"
  skip_final_snapshot             = var.skip_final_snapshot
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}
