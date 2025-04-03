import {
  to = aws_lambda_function.my_hello_lambda
  id = "my-hello-lambda"
}

import {
  to = aws_lambda_function_url.my_lambda_url
  id = "my-hello-lambda"
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.root}/build/index.mjs"
  output_path = "${path.root}/lambda-hello.zip"
}

resource "aws_lambda_function" "my_hello_lambda" {
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
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.lambda.name
  }
}

resource "aws_lambda_function_url" "my_lambda_url" {
  authorization_type = "NONE"
  function_name      = aws_lambda_function.my_hello_lambda.function_name
  invoke_mode        = "BUFFERED"
}

output "my_hello_lambda_name" {
  value = aws_lambda_function.my_hello_lambda.function_name
}

output "my_hello_lambda_url" {
  value = aws_lambda_function_url.my_lambda_url.function_url
}
