output "groups_from_everywhere" {
  value = aws_security_group.allow_from_everywhere
}

output "groups_to_everywhere" {
  value = aws_security_group.allow_to_everywhere
}

output "groups_all_to_everywhere" {
  value = aws_security_group.allow_all_to_everywhere
}

output "groups_all_to_everywhere_id" {
  value = aws_security_group.allow_all_to_everywhere.id
}