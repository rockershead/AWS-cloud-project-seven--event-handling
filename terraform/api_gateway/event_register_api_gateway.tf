# Create the REST API
resource "aws_api_gateway_rest_api" "event_handling_api" {
  name        = "EVENT_HANDLING_API"
  description = "API for event handling"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

//path
resource "aws_api_gateway_resource" "add_event" {
  rest_api_id = aws_api_gateway_rest_api.event_handling_api.id
  parent_id   = aws_api_gateway_rest_api.event_handling_api.root_resource_id
  path_part   = "events"
}







//methods
resource "aws_api_gateway_method" "event_register" {
  rest_api_id   = aws_api_gateway_rest_api.event_handling_api.id
  resource_id   = aws_api_gateway_resource.add_event.id
  http_method   = "POST"
  authorization = "NONE"
}




# Integrations
resource "aws_api_gateway_integration" "lambda_integration_event_register" {
  rest_api_id             = aws_api_gateway_rest_api.event_handling_api.id
  resource_id             = aws_api_gateway_resource.add_event.id
  http_method             = aws_api_gateway_method.event_register.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.event_register_lambda_arn
}




# Grant API Gateway permissions to invoke the Lambda functions
resource "aws_lambda_permission" "apigw_lambda_event_register" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.event_register_lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn    = "arn:aws:execute-api:ap-southeast-1:${var.account_id}:${aws_api_gateway_rest_api.event_handling_api.id}/prod/POST/events"
}




