# NiceServerlessApp

A fully automated serverless application on AWS using Infrastructure as Code (IaC) with **Terraform** as the IaC framework. Terraform handles all AWS resources in a modular format, providing declarative infrastructure management. This application demonstrates a complete serverless workflow that lists S3 objects, sends email notifications, and provides manual testing capabilities.

## 🎯 Project Goal

This project showcases a fully automated serverless application that:
- **Lists S3 objects** from a configured bucket
- **Sends email notifications** on each Lambda execution
- **Uploads local files** to the S3 bucket during deployment
- **Provides manual trigger capability** for testing purposes

## 🏗️ Architecture

The application consists of the following AWS services:
- **AWS Lambda**: Python function that lists S3 objects and sends notifications
- **Amazon S3**: Storage bucket for files
- **Amazon SNS**: Email notification service
- **AWS IAM**: Role-based permissions for Lambda execution

## 📁 Project Structure

```
NiceServerlessApp/
├── app/
│   ├── list_s3_objects_and_notify.py    # Lambda function code
│   └── list_s3_objects_and_notify.zip   # Deployed Lambda package
├── infrastructure/
│   ├── aws-setup.tf                     # AWS provider and S3 bucket
│   ├── backend.tf                       # Terraform backend configuration
│   ├── lambda-role-managment.tf         # IAM roles and policies
│   ├── lambda-setup.tf                  # Lambda function and SNS setup
│   ├── outputs.tf                       # Terraform outputs
│   ├── terraform.tfvars                 # Variable values
│   └── variables.tf                     # Variable definitions
├── .github/workflows/
│   ├── deploy.yml                       # Infrastructure deployment workflow
│   └── test-lambda.yml                  # Manual Lambda testing workflow
└── sample_files/                        # Files uploaded to S3 during deployment
```

## 🚀 Deployment

### Prerequisites

1. **AWS Account** with appropriate permissions
2. **GitHub Repository** with the following secrets configured:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_ACCOUNT_ID`
3. **Email Configuration**: Configure your email address in `infrastructure/terraform.tfvars` to receive notifications

### Deployment Process

1. **Fork or clone** this repository
2. **Configure your email** in `infrastructure/terraform.tfvars` (update the `email` variable)
3. **Configure GitHub Secrets** in your repository settings
4. **Run the deployment workflow**:
   - Go to Actions tab in GitHub
   - Select "Deploy Infrastructure" workflow
   - Click "Run workflow" → "Run workflow"

The deployment workflow will:
- Initialize and validate Terraform configuration
- Create AWS infrastructure (S3 bucket, Lambda function, SNS topic)
- Upload sample files to the S3 bucket (only if bucket is empty)
- Set up email subscription for notifications

### ⚠️ Important: Email Configuration and Confirmation Required

**Before deployment**: Make sure to configure your email address in `infrastructure/terraform.tfvars` by updating the `email` variable.

**After deployment**: **The recipient must confirm the email subscription**:
1. Check the email address specified in `infrastructure/terraform.tfvars`
2. Look for an email from AWS SNS with subject "AWS Notification - Subscription Confirmation"
3. Click the confirmation link in the email
4. Without confirmation, you won't receive notifications from the Lambda function

## 🧪 Manual Lambda Trigger

The Lambda function can be triggered manually in two ways:

### Method 1: GitHub Actions (Recommended - Ease of Use)

1. **Navigate to GitHub Actions**:
   - Go to your repository on GitHub
   - Click on the "Actions" tab
   - Select "Test Lambda Function" workflow

2. **Trigger the test**:
   - Click "Run workflow" button
   - Click "Run workflow" to confirm
   - Monitor the workflow execution

3. **View results**:
   - The workflow will invoke the Lambda function
   - Check the workflow logs for Lambda output
   - You'll receive an email notification with the results

### Method 2: AWS CLI

If you have AWS CLI configured with appropriate permissions:

```bash
# Invoke the Lambda function
aws lambda invoke \
  --function-name list-s3-and-notify \
  --payload '{"test": "manual-trigger"}' \
  --cli-binary-format raw-in-base64-out \
  response.json

# View the response
cat response.json
```

**Required AWS permissions** for CLI invocation:
- `lambda:InvokeFunction` on the `list-s3-and-notify` function

## 📧 Email Notifications

The Lambda function sends email notifications containing:
- **Bucket name** where objects were listed
- **Object count** found in the bucket
- **List of object keys** in the bucket
- **Execution status** (success/error)

## 🔧 Configuration

### Environment Variables

The Lambda function uses these environment variables:
- `S3_BUCKET_NAME`: Name of the S3 bucket to list objects from
- `SNS_TOPIC_ARN`: ARN of the SNS topic for notifications

### Customization

To customize the application:

1. **Change email recipient**: Edit `infrastructure/terraform.tfvars`
2. **Modify bucket name**: Update `s3_bucket_name` in `infrastructure/variables.tf`
3. **Change AWS region**: Update `aws_region` in `infrastructure/variables.tf`
4. **Add sample files**: Place files in the `sample_files/` directory

## 🛠️ Local Development

To work with this project locally:

1. **Install Terraform** (version 1.8.2 or later)
2. **Configure AWS credentials** locally
3. **Navigate to infrastructure directory**:
   ```bash
   cd infrastructure/
   ```
4. **Initialize Terraform**:
   ```bash
   terraform init
   ```
5. **Plan changes**:
   ```bash
   terraform plan
   ```
6. **Apply changes**:
   ```bash
   terraform apply
   ```

## 📋 Requirements

- **Terraform**: 1.8.2+
- **Python**: 3.11+ (for Lambda runtime)
- **AWS Account**: With appropriate permissions
- **GitHub Account**: For CI/CD workflows

## 🔒 Security

- No hardcoded secrets in the codebase
- IAM roles follow least privilege principle
- S3 bucket permissions are minimal and secure
- All sensitive data is stored in GitHub secrets

## 📝 License

This project is licensed under the terms specified in the LICENSE file.

