variable "s3_bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
  default     = "demo-files"
} 

variable "aws_region" {
  description = "The region of the aws s3 bucket"
  type        = string
  default     = "eu-central-1"
} 

variable "sns_topic_name" {
  description = "The name of the sns topic"
  type        = string
  default     = "lambda-topic"
}

variable "aws_account_id" {
  description = "The account id of the aws account"
  type        = string
  default     = "123456789012"
}

variable "email" {
  description = "The email address to subscribe to the SNS topic."
  type        = string
  default     = "markusofek@gmail.com"
}

