resource "aws_sns_topic" "checkout_topic" {
    name = var.event_handling_sns_checkout_topic
   
}

// permissions and policies to push to payment sqs

data "aws_iam_policy_document" "payment_sqs_queue_permissions" {
    

     //Allow sns to send message to sqs
    statement {
        effect = "Allow"
        principals {
            type        = "Service"
            identifiers = ["sns.amazonaws.com"]
        }

        actions     = ["sqs:SendMessage"]
        resources   = [aws_sqs_queue.payment_sqs_queue.arn]
        condition   {
            test        = "ArnLike"
            variable    = "aws:SourceArn"
            values      = [aws_sns_topic.checkout_topic.arn]
        }
    }

    depends_on = [
        
        aws_sqs_queue.payment_sqs_queue,
        aws_sns_topic.checkout_topic
        
    ]
}

resource "aws_sqs_queue_policy" "payment_sqs_queue_policy" {
    queue_url   = aws_sqs_queue.payment_sqs_queue.id
    policy      = data.aws_iam_policy_document.payment_sqs_queue_permissions.json

    depends_on = [
        data.aws_iam_policy_document.payment_sqs_queue_permissions,
    ]
}


// permissions and policies to push to inventory sqs

data "aws_iam_policy_document" "inventory_sqs_queue_permissions" {
    

     //Allow sns to send message to sqs
    statement {
        effect = "Allow"
        principals {
            type        = "Service"
            identifiers = ["sns.amazonaws.com"]
        }

        actions     = ["sqs:SendMessage"]
        resources   = [aws_sqs_queue.inventory_sqs_queue.arn]
        condition   {
            test        = "ArnLike"
            variable    = "aws:SourceArn"
            values      = [aws_sns_topic.checkout_topic.arn]
        }
    }

    depends_on = [
        
        aws_sqs_queue.inventory_sqs_queue,
        aws_sns_topic.checkout_topic
        
    ]
}

resource "aws_sqs_queue_policy" "inventory_sqs_queue_policy" {
    queue_url   = aws_sqs_queue.inventory_sqs_queue.id
    policy      = data.aws_iam_policy_document.inventory_sqs_queue_permissions.json

    depends_on = [
        data.aws_iam_policy_document.inventory_sqs_queue_permissions,
    ]
}

// permissions and policies to push to notification sqs

data "aws_iam_policy_document" "notification_sqs_queue_permissions" {
    

     //Allow sns to send message to sqs
    statement {
        effect = "Allow"
        principals {
            type        = "Service"
            identifiers = ["sns.amazonaws.com"]
        }

        actions     = ["sqs:SendMessage"]
        resources   = [aws_sqs_queue.notification_sqs_queue.arn]
        condition   {
            test        = "ArnLike"
            variable    = "aws:SourceArn"
            values      = [aws_sns_topic.checkout_topic.arn]
        }
    }

    depends_on = [
        
        aws_sqs_queue.notification_sqs_queue,
        aws_sns_topic.checkout_topic
        
    ]
}

resource "aws_sqs_queue_policy" "notification_sqs_queue_policy" {
    queue_url   = aws_sqs_queue.notification_sqs_queue.id
    policy      = data.aws_iam_policy_document.notification_sqs_queue_permissions.json

    depends_on = [
        data.aws_iam_policy_document.notification_sqs_queue_permissions,
    ]
}


// add subscription for the checkout  topic

resource "aws_sns_topic_subscription" "checkout_topic_payment_sqs_subscription" {
  topic_arn = aws_sns_topic.checkout_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.payment_sqs_queue.arn

  depends_on = [aws_sqs_queue.payment_sqs_queue]  
  
}

resource "aws_sns_topic_subscription" "checkout_topic_inventory_sqs_subscription" {
  topic_arn = aws_sns_topic.checkout_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.inventory_sqs_queue.arn

  depends_on = [aws_sqs_queue.inventory_sqs_queue]  
  
}

resource "aws_sns_topic_subscription" "checkout_topic_notification_sqs_subscription" {
  topic_arn = aws_sns_topic.checkout_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.notification_sqs_queue.arn

  depends_on = [aws_sqs_queue.notification_sqs_queue]  
  
}
