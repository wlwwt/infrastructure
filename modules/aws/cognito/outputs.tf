output "user_pool_id" {
  description = "The id of the user pool"
  value       = aws_cognito_user_pool.main.id
}

output "identity_pool_id" {
  description = "The id of the identity pool"
  value       = aws_cognito_identity_pool.main.id
}

output "arn" {
  description = "The ARN of the user pool"
  value       = aws_cognito_user_pool.main.arn
}

output "endpoint" {
  description = "The endpoint name of the user pool. Example format: cognito-idp.REGION.amazonaws.com/xxxx_yyyyy"
  value       = aws_cognito_user_pool.main.endpoint
}

output "creation_date" {
  description = "The date the user pool was created"
  value       = aws_cognito_user_pool.main.creation_date
}

output "client_ids" {
  description = "The ids of the user pool clients"
  value       = aws_cognito_user_pool_client.web.*.id
}