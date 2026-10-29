resource "aws_cloudwatch_event_bus" "event_handling_bus" {
  name = var.event_handling_event_bus_name
}



# data "aws_iam_policy_document" "sns_topic_policy_platform" {
#   statement {
#     effect  = "Allow"
#     actions = ["SNS:Publish"]

#     principals {
#       type        = "Service"
#       identifiers = ["events.amazonaws.com"]
#     }

#     resources = [aws_sns_topic.edge_event_handling_platform_topic.arn]

#     condition {
#       test     = "ArnEquals"
#       variable = "aws:SourceArn"
#       values   = [aws_cloudwatch_event_rule.platform_sns_topic.arn]
#     }
#   }

#   depends_on = [ aws_cloudwatch_event_rule.platform_sns_topic ]
# }

# resource "aws_sns_topic_policy" "platform" {
#   arn    = aws_sns_topic.edge_event_handling_platform_topic.arn
#   policy = data.aws_iam_policy_document.sns_topic_policy_platform.json
# }
# resource "aws_cloudwatch_event_rule" "charging_started" {
#   name           = "charging-started-rule"
#   event_bus_name = aws_cloudwatch_event_bus.event_handling_bus.name

#   event_pattern = jsonencode({
#     source      = ["ev.charging"]
#     detail-type = ["ChargingStarted"]
#   })
# }


# resource "aws_cloudwatch_event_target" "charging_started_lambda" {
#   rule           = aws_cloudwatch_event_rule.charging_started.name
#   event_bus_name = aws_cloudwatch_event_bus.event_handling_bus.name
#   target_id      = "charging-started-lambda"
#   arn            = aws_lambda_function.event_processor.arn
# }