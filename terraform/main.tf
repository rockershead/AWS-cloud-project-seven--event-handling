module "event_handling" {
  source                                 = "./event_handling"
  event_handling_table_name              = var.event_handling_table_name
  event_handling_partition_key_name      = var.event_handling_partition_key_name
  event_handling_sort_key_name           = var.event_handling_sort_key_name
  region                                 = var.region
  event_register_lambda_function_name    = var.event_register_lambda_function_name
  runtime                                = var.runtime
  event_handling_event_bus_name          = var.event_handling_event_bus_name
  event_handling_pipe_name               = var.event_handling_pipe_name
  event_handling_sns_order_shipped_topic = var.event_handling_sns_order_shipped_topic
  event_handling_sns_checkout_topic      = var.event_handling_sns_checkout_topic
  lambda_timeout_value                   = var.lambda_timeout_value
  payment_lambda_function_name           = var.payment_lambda_function_name
  inventory_lambda_function_name         = var.inventory_lambda_function_name
}