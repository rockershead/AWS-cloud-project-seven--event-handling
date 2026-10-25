module "event_handling" {
  source                              = "./event_handling"
  event_handling_table_name           = var.event_handling_table_name
  event_handling_partition_key_name   = var.event_handling_partition_key_name
  event_handling_sort_key_name        = var.event_handling_sort_key_name
  region                              = var.region
  event_register_lambda_function_name = var.event_register_lambda_function_name
  runtime                             = var.runtime
  event_register_lambda_timeout_value = var.event_register_lambda_timeout_value
}