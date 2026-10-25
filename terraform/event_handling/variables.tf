variable "event_handling_table_name" {
  type        = string
  description = "table name"


}

variable "event_handling_partition_key_name" {

  type        = string
  description = "partition key for dynamodb table"


}

variable "event_handling_sort_key_name" {

  type        = string
  description = "sort key dynamodb table"


}