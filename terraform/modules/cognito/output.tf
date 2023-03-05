output "cognito_arn" {
  value = aws_cognito_user_pool.users.arn
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.users.id
}