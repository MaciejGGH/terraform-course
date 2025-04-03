import {
  to = aws_cloudwatch_log_group.lambda
  id = "/aws/lambda/my-hello-lambda"
}

resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/my-hello-lambda"
}
