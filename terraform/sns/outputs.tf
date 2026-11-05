output "sns_order_shipped_topic_arn" {
    value = aws_sns_topic.order_shipped_topic.arn
}

output "sns_checkout_topic_arn" {
    value = aws_sns_topic.checkout_topic.arn
}