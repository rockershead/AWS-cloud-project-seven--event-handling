resource "aws_lambda_function" "order_ship_lambda" {
  filename         = "${abspath(path.cwd)}/../zip/order_ship.zip"
  source_code_hash = filebase64sha256("${abspath(path.cwd)}/../zip/order_ship.zip")
  role             = aws_iam_role.order_ship_lambda_role.arn
  function_name    = var.order_ship_lambda_function_name
  handler          = "order_ship.lambda_handler"
  runtime          = var.runtime
  timeout          = var.lambda_timeout_value

  description      = "Lambda to handle order_ship events"

  



  depends_on = [
    aws_iam_role.order_ship_lambda_role,
    
  ]
}

resource "aws_iam_role" "order_ship_lambda_role" {
  name               = "${var.order_ship_lambda_function_name}_role"
  description        = "Lambda execution role for ${var.order_ship_lambda_function_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_order_ship_lambda_role.json

  inline_policy {
    name   = "order_ship_lambda_role_policy"
    policy = data.aws_iam_policy_document.order_ship_lambda_role_permissions.json
  }
}

data "aws_iam_policy_document" "assume_order_ship_lambda_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "order_ship_lambda_role_permissions" {



  # Permissions required to access sqs
  
     statement {
        actions     = [
            "sqs:DeleteMessage",
            "sqs:GetQueueAttributes",
            "sqs:ReceiveMessage"
        ]

        resources   = [
            var.order_shipped_queue_arn
        ]

        effect      = "Allow"
    }


  

  #Cloudwatch Logs permission required for Lambda
  statement {
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_order_ship_lambda.account_id}:*"
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "logs:CreateLogStream"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_order_ship_lambda.account_id}:log-group:/aws/lambda/${var.order_ship_lambda_function_name}:*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_order_ship_lambda.account_id}:log-group:/aws/lambda/${var.order_ship_lambda_function_name}:log-stream:*"
    ]
    effect = "Allow"
  }

 
}


resource "aws_lambda_event_source_mapping" "order_ship_event_source_mapping" {
    event_source_arn    = var.order_shipped_queue_arn
    function_name       = var.order_ship_lambda_function_name
    batch_size          = 1

    scaling_config {
        maximum_concurrency = 1000
    }

    depends_on = [
        
        aws_lambda_function.order_ship_lambda
    ]
}
