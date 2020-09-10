resource "aws_s3_bucket" "main" {
  bucket = "${var.name}-${var.environment}"
  acl    = var.acl

  versioning {
    enabled = var.versioning_enabled
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_master_key_arn
        sse_algorithm     = var.sse_algorithm
      }
    }
  }

  tags = {
    Project = var.app_name
    Stage   = var.environment
  }
}