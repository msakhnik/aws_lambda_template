provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "example-of-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "example-of-terraform-locks"
    encrypt        = true
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../../src/"
  output_path = "lambda_function.zip"
}


resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "layers/lambda-layer.zip"
  layer_name = "lambda_layer"

  compatible_runtimes = ["python3.8"]
}


resource "aws_lambda_function" "lambda_template" {
  filename         = "lambda_function.zip"
  function_name    = var.lambda_name
  role             = aws_iam_role.iam_for_lambda_example.arn
  handler          = "lambda_handler.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.8"
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.example,
  ]
  layers = [aws_lambda_layer_version.lambda_layer.arn]
}


resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/${var.lambda_name}"
  retention_in_days = 14
}


resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda_example.name
  policy_arn = aws_iam_policy.lambda_logging_example.arn
}
