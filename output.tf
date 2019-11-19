output "loggshipper_lambda_arn" {
  description = "ARN of logshipper lambda function"
  value       = aws_lambda_function.s3_logshipper.arn
}

output "logshipper_role_arn" {
  description = "ARN of logshipper role"
  value       = aws_iam_role.s3_logshipper.arn
}
