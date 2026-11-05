output "inventory_queue_arn" {
  value = aws_sqs_queue.inventory_sqs_queue.arn
}

output "order_shipped_queue_arn" {
  value = aws_sqs_queue.order_shipped_sqs_queue.arn
}

output "payment_queue_arn" {
  value = aws_sqs_queue.payment_sqs_queue.arn
}

output "notification_queue_arn" {
  value = aws_sqs_queue.notification_sqs_queue.arn
}

output "inventory_queue_url" {
  value = aws_sqs_queue.inventory_sqs_queue.id
}
output "order_shipped_queue_url" {
  value = aws_sqs_queue.order_shipped_sqs_queue.id
}

output "payment_queue_url" {
  value = aws_sqs_queue.payment_sqs_queue.id
}

output "notification_queue_url" {
  value = aws_sqs_queue.notification_sqs_queue.id
}