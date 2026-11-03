variable "event_handling_table_name" {
  type        = string
  description = "table name"


}

variable "event_handling_partition_key_name" {

  type        = string
  description = "partition key for dynamodb table"


}

variable "region" {
  type        = string
  description = "aws region"

}

variable "event_handling_sort_key_name" {

  type        = string
  description = "sort key dynamodb table"


}

variable "event_register_lambda_function_name" {
  type        = string
  description = "event register lambda"
  
}

variable "runtime" {
  type        = string
  description = "runtime for python functions"
}

variable "event_register_lambda_timeout_value" {
  type        = number
  description = "timeout value for event register lambda"
 
}

variable "event_handling_event_bus_name" {

  type        = string
  description = "event bus name"
  
}

variable "event_handling_pipe_name" {

  type        = string
  description = "event handling pipe name"
  

}

variable "event_handling_sns_order_shipped_topic" {
  type        = string
  description = "SNS topic for order shipped events"
  
}

variable "event_handling_sns_checkout_topic" {
  type        = string
  description = "SNS topic for checkout events"
  
}


variable "lambda_timeout_value" {
  type        = number
  description = "timeout value for lambda functions"
  
}