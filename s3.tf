data "aws_s3_bucket" "source_bucket" {
  count  = "${var.source_bucket_count}"
  bucket = "${element(var.source_bucket_names, count.index)}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  count  = "${var.source_bucket_count}"
  name   = "${var.name}-${data.aws_s3_bucket.source_bucket.*.id[count.index]}"
  bucket = "${data.aws_s3_bucket.source_bucket.*.id[count.index]}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.s3_logshipper.arn}"
    events              = ["s3:ObjectCreated:*"]
  }
}
