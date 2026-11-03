variable "event_handling_table_name" {
  type        = string
  description = "table name"
  default     = "EVENTS_TABLE_TF"

}

variable "region" {
  type        = string
  description = "aws region"
  default     = "ap-southeast-1"

}

variable "event_handling_partition_key_name" {

  type        = string
  description = "partition key for dynamodb table"
  default     = "event_type"

}

variable "event_handling_sort_key_name" {

  type        = string
  description = "sort key dynamodb table"
  default     = "last_checked_in_ts"

}

variable "event_register_lambda_function_name" {
  type        = string
  description = "event register lambda"
  default     = "EVENT_REGISTER_TF"
}

variable "runtime" {
  type        = string
  description = "runtime for python functions"
  default     = "python3.10"
}

variable "event_register_lambda_timeout_value" {
  type        = number
  description = "timeout value for event register lambda"
  default     = 30
}

variable "event_handling_event_bus_name" {

  type        = string
  description = "event bus name"
  default     = "event-handling-bus"

}

variable "event_handling_pipe_name" {

  type        = string
  description = "event handling pipe name"
  default     = "event-handling-pipe"

}

variable "event_handling_sns_order_shipped_topic" {
  type        = string
  description = "SNS topic for order shipped events"
  default     = "order-shipped-topic"
}

variable "event_handling_sns_checkout_topic" {
  type        = string
  description = "SNS topic for checkout events"
  default     = "checkout-topic"
}

variable "lambda_timeout_value" {
  type        = number
  description = "timeout value for lambda functions"
  default     = 30
}