terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.16.0"
    }
  }
  backend "s3" {
    bucket  = "ifba-state-bucket-tf"
    region  = "us-west-2"
    key     = "terraform.state"
    encrypt = true
  }
}


provider "aws" {
  region  = "us-west-2"
  profile = var.aws_profile
}


resource "aws_s3_bucket" "state_bucket" {
  bucket = "ifba-state-bucket-tf"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "state_bucket_versioning" {
  bucket = aws_s3_bucket.state_bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }
}