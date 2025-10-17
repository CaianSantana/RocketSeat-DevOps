terraform {
  backend "s3" {
    bucket  = "state-bucket-tf-dev"
    region  = "us-west-2"
    key     = "terraform.state"
    encrypt = true
  }
}

resource "aws_s3_bucket" "state_bucket_dev" {
  bucket = "state-bucket-tf-dev"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "state_bucket_dev_state_bucket_versioning_configuration" {
  bucket = aws_s3_bucket.state_bucket_dev.bucket

  versioning_configuration {
    status = "Enabled"
  }

}