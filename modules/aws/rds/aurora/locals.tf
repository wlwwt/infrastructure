locals {
  cluster_name    = "db-${var.app_name}-${var.environment}"
  master_password = var.master_password == "" ? uuid() : var.master_password
}
