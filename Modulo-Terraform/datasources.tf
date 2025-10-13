data "aws_s3_bucket" "bucket" {
  bucket = "${var.org_name}-estudos-bucket-iac-${terraform.workspace}"
}