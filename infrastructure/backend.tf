terraform {
  backend "s3" {
    bucket         = "nice-serverless-app-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}