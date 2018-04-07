resource "aws_iam_role" "s3_logshipper" {
  name               = "${var.name}-s3-logshipper"
  assume_role_policy = "${data.aws_iam_policy_document.s3_logshipper_assume.json}"
}

data "aws_iam_policy_document" "s3_logshipper_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role_policy_attachment" "s3_logshipper-cloudwatch_access" {
  role       = "${aws_iam_role.s3_logshipper.name}"
  policy_arn = "${aws_iam_policy.cloudwatch_access.arn}"
}

resource "aws_iam_role_policy_attachment" "s3_logshipper-s3_access" {
  role       = "${aws_iam_role.s3_logshipper.name}"
  policy_arn = "${aws_iam_policy.s3_access.arn}"
}

resource "aws_iam_policy" "cloudwatch_access" {
  name   = "${var.name}-s3_logshipper-cloudwatch-access"
  policy = "${data.aws_iam_policy_document.cloudwatch_access.json}"
}

data "aws_iam_policy_document" "cloudwatch_access" {
  statement {
    sid       = "Logshipper create cloudwatch log groups"
    resources = ["arn:aws:logs:us-east-1:${var.source_account_id}:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "Logshipper write cloudwatch logs"
    resources = ["arn:aws:logs:us-east-1:${var.source_account_id}:log-group:/aws/lambda/${aws_lambda_function.s3_logshipper.name}:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_policy" "s3_access" {
  name   = "${var.name}-s3_logshipper-s3-access"
  policy = "${data.aws_iam_policy_document.s3_access.json}"
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    sid       = "Pull from source bucket"
    resources = ["${join("/*,", var.source_bucket_arns)}"]
    actions   = ["s3:GetObject"]
  }

  statement {
    sid       = "Push to target bucket"
    resources = ["${var.target_bucket_arn}/*"]

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]
  }
}
