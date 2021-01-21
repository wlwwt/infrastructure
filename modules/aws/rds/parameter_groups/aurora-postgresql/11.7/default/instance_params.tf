# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/AuroraPostgreSQL.Reference.html
resource "aws_db_parameter_group" "default" {
  name        = local.instance_pg_name
  family      = "aurora-postgresql11"
  description = "Aurora postgres11 instance-level parameter group for ${local.cluster_name} cluster"

  parameter {
    name  = "constraint_exclusion"
    value = var.constraint_exclusion
  }
  //  parameter {
  //    name  = "effective_io_concurrency"
  //    value = var.effective_io_concurrency
  //  }
  parameter {
    name  = "log_connections"
    value = var.log_connections
  }
  parameter {
    name  = "log_disconnections"
    value = var.log_disconnections
  }
  parameter {
    name  = "log_duration"
    value = var.log_duration
  }
  parameter {
    name  = "log_filename"
    value = var.log_filename
  }
  parameter {
    name  = "log_lock_waits"
    value = var.log_lock_waits
  }
  parameter {
    name  = "log_min_duration_statement"
    value = var.log_min_duration_statement
  }
  parameter {
    name  = "log_statement"
    value = var.log_statement
  }
  parameter {
    name  = "log_temp_files"
    value = var.log_temp_files
  }

  //  parameter {
  //    name         = "maintenance_work_mem"
  //    value        = var.maintenance_work_mem
  //    apply_method = "pending-reboot"
  //  }

  // For some reason, terraform gets an API error from amazon when applying this,
  // Error modifying DB Parameter Group: InvalidParameterValue: Could not find parameter with name: max_replication_slots
  // parameter {
  //   name         = "max_replication_slots"
  //   value        = var.max_replication_slots
  //   apply_method = "pending-reboot"
  // }


  // For some reason, terraform gets an API error from amazon when applying this,
  // Error modifying DB Parameter Group: InvalidParameterValue: Could not find parameter with name: max_wal_senders
  // Keep it here for future consideration. The docs still say that it should exist, and it worked in 9.6.
  // parameter {
  //   name         = "max_wal_senders"
  //   value        = var.max_wal_senders
  //   apply_method = "pending-reboot"
  // }
  parameter {
    name         = "pg_stat_statements.max"
    value        = var.pg_stat_statements_max
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "pg_stat_statements.save"
    value = var.pg_stat_statements_save
  }
  parameter {
    name  = "pg_stat_statements.track"
    value = var.pg_stat_statements_track
  }
  parameter {
    name  = "pg_stat_statements.track_utility"
    value = var.pg_stat_statements_track_utility
  }
  parameter {
    name  = "random_page_cost"
    value = var.random_page_cost
  }
  parameter {
    name  = "rds.force_admin_logging_level"
    value = var.rds_force_admin_logging_level
  }
  parameter {
    name  = "rds.log_retention_period"
    value = var.rds_log_retention_period
  }
  parameter {
    name         = "shared_preload_libraries"
    value        = var.shared_preload_libraries
    apply_method = "pending-reboot"
  }
  parameter {
    name         = "track_activity_query_size"
    value        = var.track_activity_query_size
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "track_io_timing"
    value = var.track_io_timing
  }

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}
