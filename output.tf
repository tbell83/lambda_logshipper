output "logshipper_role_arn" {
  value = "${aws_iam_role.s3_logshipper.arn}"
}

output "loggshipper_lambda_arn" {
  value = "${aws_lambda_function.s3_logshipper.arn}"
}

output "loggshipper_lambda_function_name" {
  value = "${aws_lambda_function.s3_logshipper.function_name}"
}
