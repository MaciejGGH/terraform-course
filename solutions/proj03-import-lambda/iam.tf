
import {
  to = aws_iam_role.lambda_execution_role
  id = "my-hello-lambda-role-wawh4u69"
}

import {
  to = aws_iam_policy.lambda_execution
  id = "arn:aws:iam::585768187025:policy/service-role/AWSLambdaBasicExecutionRole-88fda693-3b56-4fa7-947a-5503eaab1913"
}

data "aws_iam_policy_document" "assume_lambda_exec_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
  version = "2012-10-17"
}

resource "aws_iam_policy" "lambda_execution" {
  name        = "AWSLambdaBasicExecutionRole-88fda693-3b56-4fa7-947a-5503eaab1913"
  path        = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = "logs:CreateLogGroup"
      Effect   = "Allow"
      Resource = "arn:aws:logs:eu-west-1:585768187025:*"
      }, {
      Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:eu-west-1:585768187025:log-group:/aws/lambda/my-hello-lambda:*"]
    }]
    Version = "2012-10-17"
  })
}


resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy   = data.aws_iam_policy_document.assume_lambda_exec_role.json
  max_session_duration = 3600
  name                 = "my-hello-lambda-role-wawh4u69"
  path                 = "/service-role/"
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_execution.arn
}
