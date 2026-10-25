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