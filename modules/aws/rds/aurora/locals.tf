locals {
  master_password = var.master_password == "" ? uuid() : var.master_password
}
