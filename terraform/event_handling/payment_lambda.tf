resource "aws_lambda_function" "payment_lambda" {
  filename         = "${abspath(path.cwd)}/../zip/payment.zip"
  source_code_hash = filebase64sha256("${abspath(path.cwd)}/../zip/payment.zip")
  role             = aws_iam_role.payment_lambda_role.arn
  function_name    = var.payment_lambda_function_name
  handler          = "payment.lambda_handler"
  runtime          = var.runtime
  timeout          = var.lambda_timeout_value

  description      = "Lambda to handle payment events"

  



  depends_on = [
    aws_iam_role.payment_lambda_role,
    
  ]
}

resource "aws_iam_role" "payment_lambda_role" {
  name               = "${var.payment_lambda_function_name}_role"
  description        = "Lambda execution role for ${var.payment_lambda_function_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_payment_lambda_role.json

  inline_policy {
    name   = "payment_lambda_role_policy"
    policy = data.aws_iam_policy_document.payment_lambda_role_permissions.json
  }
}

data "aws_iam_policy_document" "assume_payment_lambda_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "payment_lambda_role_permissions" {



  # Permissions required to access sqs
  
     statement {
        actions     = [
            "sqs:DeleteMessage",
            "sqs:GetQueueAttributes",
            "sqs:ReceiveMessage"
        ]

        resources   = [
            aws_sqs_queue.payment_sqs_queue.arn
        ]

        effect      = "Allow"
    }


  

  #Cloudwatch Logs permission required for Lambda
  statement {
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_payment_lambda.account_id}:*"
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "logs:CreateLogStream"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_payment_lambda.account_id}:log-group:/aws/lambda/${var.payment_lambda_function_name}:*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_payment_lambda.account_id}:log-group:/aws/lambda/${var.payment_lambda_function_name}:log-stream:*"
    ]
    effect = "Allow"
  }

 
}


resource "aws_lambda_event_source_mapping" "event_source_mapping" {
    event_source_arn    = aws_sqs_queue.payment_sqs_queue.arn
    function_name       = var.payment_lambda_function_name
    batch_size          = 1

    scaling_config {
        maximum_concurrency = 1000
    }

    depends_on = [
        aws_sqs_queue.payment_sqs_queue,
        aws_lambda_function.payment_lambda
    ]
}
