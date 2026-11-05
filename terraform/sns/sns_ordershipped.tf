resource "aws_sns_topic" "order_shipped_topic" {
    name = var.event_handling_sns_order_shipped_topic
   
}

// permissions and policies to push to order shipped sqs

data "aws_iam_policy_document" "order_shipped_sqs_queue_permissions" {
    

     //Allow sns to send message to sqs
    statement {
        effect = "Allow"
        principals {
            type        = "Service"
            identifiers = ["sns.amazonaws.com"]
        }

        actions     = ["sqs:SendMessage"]
        resources   = [var.order_shipped_queue_arn]
        condition   {
            test        = "ArnLike"
            variable    = "aws:SourceArn"
            values      = [aws_sns_topic.order_shipped_topic.arn]
        }
    }

    depends_on = [
        
        
        aws_sns_topic.order_shipped_topic
        
    ]
}

resource "aws_sqs_queue_policy" "order_shipped_sqs_queue_policy" {
    queue_url   = var.order_shipped_queue_url
    policy      = data.aws_iam_policy_document.order_shipped_sqs_queue_permissions.json

    depends_on = [
        data.aws_iam_policy_document.order_shipped_sqs_queue_permissions,
    ]
}


// add subscription for the order shipped topic

resource "aws_sns_topic_subscription" "order_shipped_topic_order_shipped_sqs_subscription" {
  topic_arn = aws_sns_topic.order_shipped_topic.arn
  protocol  = "sqs"
  endpoint  = var.order_shipped_queue_arn

   
  
}