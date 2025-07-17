provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "demo-files-bucket" {
  bucket = var.s3_bucket_name
}
