module "event_handling" {
  source                              = "./event_handling"
  event_handling_table_name           = var.event_handling_table_name
  event_handling_partition_key_name   = var.event_handling_partition_key_name
  event_handling_sort_key_name        = var.event_handling_sort_key_name
}