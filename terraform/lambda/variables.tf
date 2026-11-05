variable "event_handling_table_name" {
  type        = string
  description = "table name"


}

variable "region" {
  type        = string
  description = "aws region"

}


variable "event_register_lambda_function_name" {
  type        = string
  description = "event register lambda"
  
}

variable "payment_lambda_function_name" {
  type        = string
  description = "payment lambda"
  
}

variable "inventory_lambda_function_name" {
  type        = string
  description = "inventory lambda"
  
}


variable "runtime" {
  type        = string
  description = "runtime for python functions"
}

variable "lambda_timeout_value" {
  type        = number
  description = "timeout value for lambda functions"
}

variable "order_ship_lambda_function_name" {
  type        = string
  description = "order ship lambda"
 
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
