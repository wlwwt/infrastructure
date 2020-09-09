## REQUIRED {
variable "cluster_name" {
  description = "The name of DB cluster which will be using these parameter groups"
}

## REQUIRED }

variable "tags" {
  type        = map
  description = "A mapping for tags to assign to parameter groups"
  default     = {}
}

## cluster-level params {
variable "autovacuum" {
  default = "1"
}

variable "autovacuum_analyze_scale_factor" {
  default = "0.02"
}

variable "autovacuum_vacuum_scale_factor" {
  default = "0.05"
}

variable "log_autovacuum_min_duration" {
  default = "0"
}

variable "rds_force_autovacuum_logging_level" {
  default = "log"
}

variable "rds_logical_replication" {
  description = "Allows DMS from this cluster. "
  default     = "1"
}

## cluster-level params }

## instance-level params {

variable "constraint_exclusion" {
  default = "partition"
}

variable "effective_io_concurrency" {
  default = "200"
}

variable "log_connections" {
  default = "1"
}

variable "log_disconnections" {
  default = "1"
}

variable "log_duration" {
  default = "0"
}

variable "log_filename" {
  default = "postgresql.log.%Y-%m-%d"
}

variable "log_lock_waits" {
  default = "1"
}

variable "log_min_duration_statement" {
  default = "10"
}

variable "log_statement" {
  default = "ddl"
}

variable "log_temp_files" {
  default = "0"
}

// This formula doesn't work with terraform, don't set a constant for now.
//variable "maintenance_work_mem" {
//  default = "GREATEST({DBInstanceClassMemory/63963136*1024},65536)"
//}

variable "max_replication_slots" {
  default = "20"
}

variable "max_wal_senders" {
  default = "20"
}

variable "pg_stat_statements_max" {
  default = "20000"
}

variable "pg_stat_statements_save" {
  default = "1"
}

variable "pg_stat_statements_track" {
  default = "ALL"
}

variable "pg_stat_statements_track_utility" {
  default = "1"
}

variable "random_page_cost" {
  description = "We use SSD's so the planner should not see random page cost as very expensive."
  default     = "1"
}

variable "rds_force_admin_logging_level" {
  default = "log"
}

variable "rds_log_retention_period" {
  default = "10080"
}

// Note, rds.pg_stat_ramdisk_size does not exist in aurora.

// This formula does not work with terraform, don't try to set a constant
//variable "shared_buffers" {
//  default = "{DBInstanceClassMemory/10922}"
//}

variable "shared_preload_libraries" {
  default = "pg_stat_statements"
}

variable "track_activity_query_size" {
  default = "4096"
}

variable "track_io_timing" {
  default = "1"
}

variable "wal_sender_timeout" {
  default = "0"
}
