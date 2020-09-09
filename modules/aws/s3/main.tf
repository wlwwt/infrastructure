resource "aws_s3_bucket" "main" {
  bucket  = "${var.name}-${var.environment}"
  acl     = var.acl

  versioning {
    enabled = var.versioning_enabled
  }

  tags = {
    Project = var.app_name
    Stage   = var.environment
  }
}