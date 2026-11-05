variable "event_handling_sns_order_shipped_topic" {
  type        = string
  description = "SNS topic for order shipped events"
  
}

variable "event_handling_sns_checkout_topic" {
  type        = string
  description = "SNS topic for checkout events"
  
}

variable "inventory_queue_arn" {
  type        = string
  description = "ARN of the SQS inventory queue"
}

variable "payment_queue_arn" {
  type        = string
  description = "ARN of the SQS payment queue"
}

variable "order_shipped_queue_arn" {
  type        = string
  description = "ARN of the SQS order shipped queue"
}


variable "inventory_queue_url" {
  type        = string
  description = "URL of the SQS inventory queue"
}

variable "order_shipped_queue_url" {
  type        = string
  description = "URL of the SQS order shipped queue"
}

variable "payment_queue_url" {
  type        = string
  description = "URL of the SQS payment queue"
}

variable "notification_queue_arn" {
  type        = string
  description = "ARN of the SQS notification queue"
}

variable "notification_queue_url" {
  type        = string
  description = "URL of the SQS notification queue"
}