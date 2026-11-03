resource "aws_lambda_function" "event_register_lambda" {
  filename         = "${abspath(path.cwd)}/../zip/event_register.zip"
  source_code_hash = filebase64sha256("${abspath(path.cwd)}/../zip/event_register.zip")
  role             = aws_iam_role.event_register_lambda_role.arn
  function_name    = var.event_register_lambda_function_name
  handler          = "event_register.lambda_handler"
  runtime          = var.runtime
  timeout          = var.lambda_timeout_value

  description      = "Lambda to handle event registration"

  #vpc_config {
  #  security_group_ids = [aws_security_group.security_group.id]
  #  subnet_ids         = tolist(aws_subnet.private_subnets[*].id)
  #}

  environment {
    variables = {
      TABLE_NAME           = var.event_handling_table_name
      REGION               = var.region
    }
  }

  depends_on = [
    aws_iam_role.event_register_lambda_role,
    
  ]
}

resource "aws_iam_role" "event_register_lambda_role" {
  name               = "${var.event_register_lambda_function_name}_role"
  description        = "Lambda execution role for ${var.event_register_lambda_function_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_event_register_lambda_role.json

  inline_policy {
    name   = "event_register_lambda_role_policy"
    policy = data.aws_iam_policy_document.event_register_lambda_role_permissions.json
  }
}

data "aws_iam_policy_document" "assume_event_register_lambda_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "event_register_lambda_role_permissions" {



  # Permissions required to read registration dynamodb
  statement {
    actions = [

      "dynamodb:PutItem"

    ]

    resources = [
      "arn:aws:dynamodb:ap-southeast-1:${data.aws_caller_identity.current_caller_for_event_register_lambda.account_id}:table/${var.event_handling_table_name}",

    ]

    effect = "Allow"
  }



  

  #Cloudwatch Logs permission required for Lambda
  statement {
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_event_register_lambda.account_id}:*"
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "logs:CreateLogStream"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_event_register_lambda.account_id}:log-group:/aws/lambda/${var.event_register_lambda_function_name}:*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_event_register_lambda.account_id}:log-group:/aws/lambda/${var.event_register_lambda_function_name}:log-stream:*"
    ]
    effect = "Allow"
  }

  depends_on = [
    aws_dynamodb_table.event_handling_table
  ]
}
