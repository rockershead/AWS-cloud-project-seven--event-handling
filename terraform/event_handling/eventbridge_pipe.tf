

resource "aws_iam_role" "event_pipe_role" {
  name               = "${var.event_handling_pipe_name}_role"
  description        = "Pipe execution role for ${var.event_handling_pipe_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_event_pipe_role.json

  inline_policy {
    name   = "event_pipe_role_policy"
    policy = data.aws_iam_policy_document.event_pipe_role_permissions.json
  }
}



data "aws_iam_policy_document" "assume_event_pipe_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pipes.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "event_pipe_role_permissions" {



  # Permissions required to read dynamodb stream
  statement {
    actions = [

      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams"

    ]

    resources = [
      aws_dynamodb_table.event_handling_table.stream_arn,

    ]

    effect = "Allow"
  }
  statement {
    actions = [

      "events:PutEvents"

    ]

    resources = [
      aws_cloudwatch_event_bus.event_handling_bus.arn,

    ]

    effect = "Allow"
  }
  
  

}


resource "aws_pipes_pipe" "event_handling_pipe" {
  name     = var.event_handling_pipe_name
  role_arn = aws_iam_role.event_pipe_role.arn
  source   = aws_dynamodb_table.event_handling_table.stream_arn
  target   = aws_cloudwatch_event_bus.event_handling_bus.arn
  
  // source parameter configuration for the DynamoDB stream is mandatory only for dynmodb stream
  source_parameters {
    dynamodb_stream_parameters {
      starting_position = "LATEST"
      batch_size        = 10
    }

#     filter_criteria {
#       filter {
#         pattern = jsonencode({
#           eventName = ["INSERT", "MODIFY"]
#         })
#       }
#     }
#   }

#   target_parameters {
#     eventbridge_event_bus_parameters {
#       source      = "ev.charging"
#       detail_type = "ChargingEvent"
#     }
#   }

  depends_on = [
    aws_iam_role.event_pipe_role,
    aws_cloudwatch_event_bus.event_handling_bus
  ]
}