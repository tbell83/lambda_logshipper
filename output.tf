output "logshipper_role_arn" {
  value = "${aws_iam_role.s3_logshipper.arn}"
}
