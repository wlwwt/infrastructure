resource "aws_cloudwatch_log_group" "lg" {
  name              = "/${var.resource}/${var.app_name}-${var.environment}"
  retention_in_days = var.retention_in_days

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}