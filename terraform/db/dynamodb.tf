resource "aws_dynamodb_table" "event_handling_table" {
  name                        = var.event_handling_table_name
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = false

  stream_enabled              = true
  stream_view_type            = "NEW_IMAGE"


  hash_key                    = var.event_handling_partition_key_name  # Partition key
  range_key                   = var.event_handling_sort_key_name  # Sort key

  # Partition Key ( "event_type" )
  attribute {
    name = var.event_handling_partition_key_name
    type = "S"
  }

  # Sort Key ("last_checked_in_ts")
  attribute {
  name = var.event_handling_sort_key_name
  type = "N"
  }



  //global_secondary_index {
  //  name        = "${var.event_handling_sort_key_name}-index"
  // hash_key    = var.event_handling_sort_key_name
  // range_key   = var.event_handling_attr_status_key_name
  // projection_type = "ALL"

  //}



  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity
    ]
  }
}

