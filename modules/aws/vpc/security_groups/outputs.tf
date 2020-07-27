output "groups_from_everywhere" {
  value = aws_security_group.allow_from_everywhere
}

output "groups_allow_all_to_intranet" {
  value = aws_security_group.allow_all_to_intranet.id
}

output "groups_all_to_everywhere_id" {
  value = aws_security_group.allow_all_to_everywhere.id
}