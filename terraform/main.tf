module "db" {
  source                                  = "./db"
  event_handling_table_name               = var.event_handling_table_name
  event_handling_partition_key_name       = var.event_handling_partition_key_name
  event_handling_sort_key_name            = var.event_handling_sort_key_name
  region                                  = var.region
}

module "event_bus_bridge" {
  source                                  = "./event_bus_bridge"
  event_handling_event_bus_name           = var.event_handling_event_bus_name
  event_handling_pipe_name                = var.event_handling_pipe_name
  event_handling_table_stream_arn         = module.db.event_handling_table_stream_arn
  sns_order_shipped_topic_arn             = module.sns.sns_order_shipped_topic_arn
  sns_checkout_topic_arn                  = module.sns.sns_checkout_topic_arn
  depends_on                              = [module.sns]
}

module "sns" {
  source                                  = "./sns"
  event_handling_sns_order_shipped_topic  = var.event_handling_sns_order_shipped_topic
  event_handling_sns_checkout_topic       = var.event_handling_sns_checkout_topic
  inventory_queue_arn                     = module.sqs.inventory_queue_arn
  payment_queue_arn                       = module.sqs.payment_queue_arn
  order_shipped_queue_arn                 = module.sqs.order_shipped_queue_arn
  inventory_queue_url                     = module.sqs.inventory_queue_url
  payment_queue_url                       = module.sqs.payment_queue_url
  order_shipped_queue_url                 = module.sqs.order_shipped_queue_url
  notification_queue_arn                  = module.sqs.notification_queue_arn
  notification_queue_url                  = module.sqs.notification_queue_url
  depends_on                              = [ module.sqs ]
}

module "sqs" {
  source                                  = "./sqs"
  lambda_timeout_value                    = var.lambda_timeout_value
}

module "lambda" {
  source                                  = "./lambda"
  event_register_lambda_function_name     = var.event_register_lambda_function_name
  payment_lambda_function_name            = var.payment_lambda_function_name
  inventory_lambda_function_name          = var.inventory_lambda_function_name
  order_ship_lambda_function_name         = var.order_ship_lambda_function_name
  runtime                                 = var.runtime
  lambda_timeout_value                    = var.lambda_timeout_value
  region                                  = var.region
  event_handling_table_name               = var.event_handling_table_name
  inventory_queue_arn                     = module.sqs.inventory_queue_arn
  payment_queue_arn                       = module.sqs.payment_queue_arn
  order_shipped_queue_arn                 = module.sqs.order_shipped_queue_arn
  depends_on                              = [ module.sqs,module.db ]
}

module "api_gateway" {
  source                                  = "./api_gateway"
  event_register_lambda_function_name     = module.lambda.event_register_lambda_function_name
  event_register_lambda_arn               = module.lambda.event_register_lambda_arn
}