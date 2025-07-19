import os
import boto3
import json

s3_bucket = os.environ["S3_BUCKET_NAME"]
sns_topic_arn = os.environ["SNS_TOPIC_ARN"]
s3 = boto3.client("s3")
sns = boto3.client("sns")

def lambda_handler(event, context):
    try:
        response = s3.list_objects_v2(Bucket=s3_bucket)
        objects = [obj["Key"] for obj in response.get("Contents", [])]
        message = {
            "bucket": s3_bucket,
            "object_count": len(objects),
            "objects": objects
        }
        sns.publish(
            TopicArn=sns_topic_arn,
            Message=json.dumps(message),
            Subject="S3 Bucket Listing Lambda Execution"
        )
        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Success", "details": message})
        }
    except Exception as e:
        error_message = f"Error: {str(e)}"
        sns.publish(
            TopicArn=sns_topic_arn,
            Message=error_message,
            Subject="S3 Bucket Listing Lambda Error"
        )
        return {
            "statusCode": 500,
            "body": json.dumps({"message": error_message})
        } 