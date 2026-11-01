resource "aws_cloudwatch_event_bus" "event_handling_bus" {
  name = var.event_handling_event_bus_name
}


## to process checkout events
resource "aws_cloudwatch_event_rule" "checkout_sns_topic" {
  name           = "checkout_sns_topic_rule"
  event_bus_name = aws_cloudwatch_event_bus.event_handling_bus.name
  event_pattern  = jsonencode({
    "source": ["Pipe ${var.event_handling_pipe_name}"],
    "detail": {
        "dynamodb": {
            "NewImage": {
                "event_type": {
                    "S": ["checkout"]
                }
        }
        }
    }
  })
}



resource "aws_cloudwatch_event_target" "checkout_event_sns_topic_target" {
  rule      = aws_cloudwatch_event_rule.checkout_sns_topic.name
  event_bus_name = aws_cloudwatch_event_bus.event_handling_bus.name
  arn       = aws_sns_topic.checkout__topic.arn
  

  depends_on = [ aws_sns_topic.checkout_topic  ]
}

## permission for eventbus to sns
resource "aws_sns_topic_policy" "checkout_topic" {
  arn    = aws_sns_topic.checkout_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy_checkout.json
}

data "aws_iam_policy_document" "sns_topic_policy_checkout" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.checkout_topic.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudwatch_event_rule.checkout_sns_topic.arn]
    }
  }

  depends_on = [ aws_cloudwatch_event_rule.checkout_sns_topic ]
}

 


## to process order shipped events

resource "aws_cloudwatch_event_rule" "order_shipped_sns_topic" {
  name           = "order_shipped_sns_topic_rule"
  event_bus_name = aws_cloudwatch_event_bus.event_handling_bus.name
  event_pattern  = jsonencode({
    "source": ["Pipe ${var.event_handling_pipe_name}"],
    "detail": {
        "dynamodb": {
            "NewImage": {
                "event_type": {
                    "S": ["order_shipped"]
                }
        }
        }
    }
  })
}



resource "aws_cloudwatch_event_target" "order_shipped_event_sns_topic_target" {
  rule           = aws_cloudwatch_event_rule.order_shipped_sns_topic.name
  event_bus_name = aws_cloudwatch_event_bus.event_handling_bus.name
  arn            = aws_sns_topic.order_shipped_topic.arn
  

  depends_on = [ aws_sns_topic.order_shipped_topic  ]
}

## permission for eventbus to sns
resource "aws_sns_topic_policy" "order_shipped_topic" {
  arn    = aws_sns_topic.order_shipped_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy_order_shipped.json
}

data "aws_iam_policy_document" "sns_topic_policy_order_shipped" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.order_shipped_topic.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudwatch_event_rule.order_shipped_sns_topic.arn]
    }
  }

  depends_on = [ aws_cloudwatch_event_rule.order_shipped_sns_topic ]
}