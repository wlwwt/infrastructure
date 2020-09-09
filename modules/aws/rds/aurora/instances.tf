# https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html
resource "aws_rds_cluster_instance" "main" {
  count = var.cluster_count

  identifier                   = "${var.cluster_name}-${count.index + 1}"
  cluster_identifier           = aws_rds_cluster.main.id
  engine                       = var.engine
  engine_version               = var.engine_version
  instance_class               = var.instance_class
  publicly_accessible          = var.publicly_accessible
  db_subnet_group_name         = var.db_subnet_group_name
  db_parameter_group_name      = var.instance_parameter_group_name
  apply_immediately            = var.apply_immediately
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  performance_insights_enabled = var.performance_insights_enabled
  tags                         = var.tags
}
