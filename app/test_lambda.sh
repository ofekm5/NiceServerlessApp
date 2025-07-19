#!/bin/bash
# test_lambda.sh
# This script manually invokes the 'list-s3-and-notify' Lambda function using AWS CLI.
# Make sure your AWS CLI is configured with the correct credentials and region.

# Usage: bash test_lambda.sh

aws lambda invoke \
  --function-name list-s3-and-notify \
  --payload '{"test": "manual-trigger"}' \
  --cli-binary-format raw-in-base64-out \
  response.json

echo "Lambda output:"
cat response.json 