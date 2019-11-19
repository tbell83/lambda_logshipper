resource "aws_lambda_function" "s3_logshipper" {
  filename         = "${path.module}/payload.zip"
  source_code_hash = filebase64sha256("${path.module}/payload.zip")
  function_name    = "${var.name}_s3_logshipper"
  role             = aws_iam_role.s3_logshipper.arn
  runtime          = var.lambda_runtime
  handler          = "index.handler"
  tags             = var.tags

  environment {
    variables = {
      TARGET_PATH   = var.target_path
      TARGET_BUCKET = var.target_bucket
      TARGET_ACL    = var.target_acl
    }
  }

  lifecycle {
    ignore_changes = [filename, last_modified]
  }
}

resource "aws_lambda_permission" "s3_trigger" {
  count          = var.source_bucket_count
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.s3_logshipper.function_name
  principal      = "s3.amazonaws.com"
  statement_id   = "${var.name}-s3-logshipper${count.index}"
  source_account = var.source_account_id
  source_arn     = data.aws_s3_bucket.source_bucket.*.arn[count.index]
}

resource "aws_cloudwatch_log_group" "s3_logshipper" {
  name              = "/aws/lambda/${var.name}_s3_logshipper"
  retention_in_days = var.log_retention
  tags              = var.tags
}
