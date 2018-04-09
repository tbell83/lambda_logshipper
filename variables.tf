variable "tags" {
  description = "tags"
  type        = "map"

  default = {
    "Managed" = "Terraform"
    "Name"    = "logshipper"
  }
}

variable "name" {
  description = "Prefix for resources in module"
  type        = "string"
  default     = "logshipper"
}

variable "source_account_id" {
  description = "AWS Account ID"
  type        = "string"
}

variable "source_bucket_names" {
  description = "Name of bucket being montoring for events"
  type        = "list"
}

variable "target_bucket" {
  description = "Name of destination log bucket"
  type        = "string"
}

variable "target_bucket_arn" {
  description = "ARN of destination log bucket"
  type        = "string"
}

variable "target_path" {
  description = "Prefix for objects in destination log bucket"
  type        = "string"
}

variable "source_bucket_count" {
  description = "Number of source buckets to trigger the lambda. Due to a limitation of terraform we cannot simply compute the length of the `source_bucket_arns` list when it contains computed values. https://github.com/hashicorp/terraform/issues/17421"
  type        = "string"
}
