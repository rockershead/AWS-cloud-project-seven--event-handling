variable "event_handling_event_bus_name" {

  type        = string
  description = "event bus name"
  
}

variable "event_handling_pipe_name" {

  type        = string
  description = "event handling pipe name"
  

}

variable "event_handling_table_stream_arn" {

  type        = string
  description = "event handling table stream ARN"

}

variable "sns_order_shipped_topic_arn" {

  type        = string
  description = "SNS order shipped topic ARN"

}

variable "sns_checkout_topic_arn" {

  type        = string
  description = "SNS checkout topic ARN"

}
