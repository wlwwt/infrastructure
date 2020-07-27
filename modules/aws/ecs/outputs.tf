output "execution_role_arn" {
  value = aws_iam_role.ecsTaskExecutionRole.arn
}

output "id" {
  value = aws_ecs_cluster.main.id
}

output "task_sg" {
  value = aws_security_group.ecs_tasks
}