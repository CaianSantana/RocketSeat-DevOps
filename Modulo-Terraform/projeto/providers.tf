terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.17.0"
    }
  }
  backend "s3" {
    bucket  = "state-bucket-tf-projeto"
    region  = "us-west-2"
    key     = "terraform.state"
    encrypt = true
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

resource "aws_s3_bucket" "state-bucket" {
  bucket = "state-bucket-tf-projeto"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "state_bucket_versioning_configuration" {
  bucket = aws_s3_bucket.state-bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }

}