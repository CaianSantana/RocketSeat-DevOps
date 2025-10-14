data "aws_s3_bucket" "bucket"{
    bucket= "${var.org_name}-${var.bucket_name}-${terraform.workspace}"
}