resource "random_id" "project_bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = "${local.project}-${random_id.project_bucket_suffix.hex}"
  tags   = merge(local.common_tags, var.additional_tags)
}

variable "my_sensitive_value" {
  type      = string
  sensitive = true
  default   = "top-secret"
}
