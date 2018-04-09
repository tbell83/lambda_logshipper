data "aws_s3_bucket" "source_bucket" {
  count  = "${var.source_bucket_count}"
  bucket = "${element(var.source_bucket_names, count.index)}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  count  = "${var.source_bucket_count}"
  bucket = "${data.aws_s3_bucket.source_bucket"${count.index}".id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.func1.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "AWSLogs/"
    filter_suffix       = ".log"
  }

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.func2.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "OtherLogs/"
    filter_suffix       = ".log"
  }
}
