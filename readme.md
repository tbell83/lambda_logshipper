
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | Prefix for resources in module | string | `lambda_logshipper` | no |
| source_account_id | AWS Account ID | string | - | yes |
| source_bucket_arns | ARN of bucket being montoring for events | list | - | yes |
| tags | tags | map | `<map>` | no |
| target_bucket | Name of destination log bucket | string | - | yes |
| target_bucket_arn | ARN of destination log bucket | string | - | yes |
| target_path | Prefix for objects in destination log bucket | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| logshipper_role_arn |  |

