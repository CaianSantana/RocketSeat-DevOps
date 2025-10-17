terraform {
  backend "s3" {
    bucket  = "state-bucket-tf-test"
    region  = "us-west-2"
    key     = "terraform.state"
    encrypt = true
  }
}

resource "aws_s3_bucket" "state_bucket_test" {
  bucket = "state-bucket-tf-test"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "state_bucket_test_versioning_configuration" {
  bucket = aws_s3_bucket.state_bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }

}