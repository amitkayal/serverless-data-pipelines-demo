resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_name
  s3_bucket = var.s3_bucket_name
  s3_key    = var.s3_key
  s3_object_version = var.s3_object_version
  tags = var.tags

  # "main" is the filename within the zip file and "handler"
  # is the method to be called in that file.
  handler = "src/main.handler"
  runtime = "python3.7"
  timeout = var.timeout_seconds
  memory_size = var.lambda_memory_size

  environment {
    variables = var.env_vars
    }

  role = var.lambda_execution_role_arn
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = var.log_retention_days
  tags = var.tags
}
