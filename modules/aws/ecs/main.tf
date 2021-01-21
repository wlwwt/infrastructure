resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-${var.environment}"

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}