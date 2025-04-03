
import {
  to = aws_iam_role.lambda_execution_role
  id = "my-hello-lambda-role-wawh4u69"
}

import {
  to = aws_iam_policy.lambda_execution
  id = "arn:aws:iam::585768187025:policy/service-role/AWSLambdaBasicExecutionRole-88fda693-3b56-4fa7-947a-5503eaab1913"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

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

data "aws_iam_policy_document" "assume_lambda_execution" {
  statement {
    actions   = ["logs:CreateLogGroup"]
    effect    = "Allow"
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }
  statement {
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    effect    = "Allow"
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/my-hello-lambda:*"]
  }
  version = "2012-10-17"
}

resource "aws_iam_policy" "lambda_execution" {
  name = "AWSLambdaBasicExecutionRole-88fda693-3b56-4fa7-947a-5503eaab1913"
  path = "/service-role/"
  policy = data.aws_iam_policy_document.assume_lambda_execution.json
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
