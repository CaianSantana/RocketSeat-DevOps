terraform {
  backend "s3" {
    bucket  = "state-bucket-tf-prod"
    region  = "us-west-2"
    key     = "terraform.state"
    encrypt = true
  }
}

resource "aws_s3_bucket" "state_bucket_prod" {
  bucket = "state-bucket-tf-prod"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "state_bucket_prod_versioning_configuration" {
  bucket = aws_s3_bucket.state_bucket_prod.bucket

  versioning_configuration {
    status = "Enabled"
  }

}