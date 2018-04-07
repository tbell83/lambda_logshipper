variable "tags" {
  description = "tags"
  type        = "map"

  default = {
    "Managed" = "Terraform"
    "Name"    = "cwl"
  }
}

variable "name" {
  description = "Prefix for resources in module"
  type        = "string"
  default     = "lambda_logshipper"
}

variable "source_account_id" {
  description = "AWS Account ID"
  type        = "string"
}

variable "source_bucket_arns" {
  description = "ARN of bucket being montoring for events"
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
