import {
  to = aws_lambda_function.test_lambda
  id = "my-hello-lambda"
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.root}/build/index.mjs"
  output_path = "${path.root}/lambda-hello.zip"
}

resource "aws_lambda_function" "test_lambda" {
  description      = "A starter AWS Lambda function."
  filename         = "lambda-hello.zip"
  function_name    = "my-hello-lambda"
  handler          = "index.handler"
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = "nodejs18.x"
  publish          = true
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  tags = {
    "lambda-console:blueprint" = "hello-world"
  }
  timeout = 3
  logging_config {
    application_log_level = null
    log_format            = "Text"
    log_group             = "/aws/lambda/my-hello-lambda"
    system_log_level      = null
  }
}
