resource "aws_lambda_function" "s3_logshipper" {
  filename      = "${path.module}/payload.zip"
  function_name = "${var.name}_s3_logshipper"
  role          = "${aws_iam_role.s3_logshipper.arn}"
  runtime       = "nodejs6.10"
  handler       = "index.handler"
  tags          = "${var.tags}"

  environment {
    variables {
      "TARGET_PATH"   = "${var.target_path}"
      "TARGET_BUCKET" = "${var.target_bucket}"
    }
  }
}

resource "aws_lambda_permission" "s3_trigger" {
  count          = "${var.source_bucket_count}"
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.s3_logshipper.function_name}"
  principal      = "s3.amazon.com"
  statement_id   = "${var.name}-s3-logshipper${count.index}"
  source_account = "${var.source_account_id}"
  source_arn     = "${element(var.source_bucket_arns, count.index)}"
}
