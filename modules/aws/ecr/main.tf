resource "aws_ecr_repository" "app_repository" {
  name = "${var.app_name}-${var.environment}"

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}