## REQUIRED {
variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_count" {
  type        = number
  description = "The number of instances in the cluster"
}

variable "cluster_parameter_group_name" {
  type        = string
  description = "The name of cluster parameter group to associate with the cluster"
}

variable "instance_parameter_group_name" {
  type        = string
  description = "The name of the DB parameter group to associate with instances"
}

variable "db_subnet_group_name" {
  type        = string
  description = "DB subnet group name"
}

## REQUIRED }

variable "master_username" {
  description = "Username for the master DB user"
  default     = "root"
}

variable "master_password" {
  description = "Password for the master DB user. Can/should be changed outside of terraform"
  default     = ""
}

variable "instance_class" {
  description = "The instance class. See the list of supported classes for Aurora Postgresql"
  default     = "db.t3.medium"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  default     = false
}

variable "engine" {
  description = "Engine name (e.g., aurora, aurora-mysql, aurora-postgresql)"
  default     = "aurora-postgresql"
}

variable "engine_version" {
  description = "Engine version"
  default     = "11.7"
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  default     = 1
}

variable "snapshot_identifier" {
  description = "DB snapshot to create this database from"
  default     = ""
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created if automated backups are enabled. Time in UTC."
  default     = "07:00-09:00"
}

variable "preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur in UTC (e.g. wed:04:00-wed:04:30)"
  default     = "sun:05:00-sun:06:00"
}

variable "port" {
  description = "The port on which the DB accepts connections"
  default     = "5432"
}

variable "security_group_ids" {
  description = "List of VPC security groups names to associate with the Cluster"
  default     = []
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = true
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights is enabled or not."
  default     = true
}