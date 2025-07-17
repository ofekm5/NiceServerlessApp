provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "demo-files-bucket" {
  bucket = var.s3_bucket_name
}