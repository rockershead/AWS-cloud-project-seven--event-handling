
## for subscription to checkout sns
resource "aws_sqs_queue" "payment_sqs_queue" {
    name                        = "payment-sqs-queue"
    delay_seconds               = 0
    # Recommended to be 6 times of lambda timeout
    visibility_timeout_seconds  = 6 * var.lambda_timeout_value
    max_message_size            = 10240
    message_retention_seconds   = 3600
    # SQS can wait up to 20 seconds for a message before returning an empty response. prevents lambda from doing short polling which incurs more costs
    receive_wait_time_seconds   = 20
    sqs_managed_sse_enabled     = true
}

resource "aws_sqs_queue" "inventory_sqs_queue" {
    name                        = "inventory-sqs-queue"
    delay_seconds               = 0
    # Recommended to be 6 times of lambda timeout
    visibility_timeout_seconds  = 6 * var.lambda_timeout_value
    max_message_size            = 10240
    message_retention_seconds   = 3600
    # SQS can wait up to 20 seconds for a message before returning an empty response. prevents lambda from doing short polling which incurs more costs
    receive_wait_time_seconds   = 20
    sqs_managed_sse_enabled     = true
}

resource "aws_sqs_queue" "notification_sqs_queue" {
    name                        = "notification-sqs-queue"
    delay_seconds               = 0
    # Recommended to be 6 times of lambda timeout
    visibility_timeout_seconds  = 6 * var.lambda_timeout_value
    max_message_size            = 10240
    message_retention_seconds   = 3600
    # SQS can wait up to 20 seconds for a message before returning an empty response. prevents lambda from doing short polling which incurs more costs
    receive_wait_time_seconds   = 20
    sqs_managed_sse_enabled     = true
}




## for subscription to order shipped sns

resource "aws_sqs_queue" "order_shipped_sqs_queue" {
    name                        = "order-shipped-sqs-queue"
    delay_seconds               = 0
    # Recommended to be 6 times of lambda timeout
    visibility_timeout_seconds  = 6 * var.lambda_timeout_value
    max_message_size            = 10240
    message_retention_seconds   = 3600
    # SQS can wait up to 20 seconds for a message before returning an empty response. prevents lambda from doing short polling which incurs more costs
    receive_wait_time_seconds   = 20
    sqs_managed_sse_enabled     = true
}