resource "aws_sns_topic" "lambda_notify_topic" {
  name = "lambda-notify-topic"
}

resource "aws_lambda_function" "list_s3_objects_and_notify" {
  function_name = "list-s3-and-notify"
  role          = aws_iam_role.lambda_role.arn
  handler       = "list_s3_objects_and_notify.lambda_handler"
  runtime       = "python3.11"
  filename      = "${path.module}/../app/list_s3_objects_and_notify.zip"
  source_code_hash = filebase64sha256("${path.module}/../app/list_s3_objects_and_notify.zip")
  environment {
    variables = {
      S3_BUCKET_NAME = var.s3_bucket_name
      SNS_TOPIC_ARN  = aws_sns_topic.lambda_notify_topic.arn
    }
  }
}

resource "aws_lambda_permission" "allow_sns_invoke" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.list_s3_objects_and_notify.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.lambda_notify_topic.arn
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.lambda_notify_topic.arn
  protocol  = "email"
  endpoint  = var.email
}