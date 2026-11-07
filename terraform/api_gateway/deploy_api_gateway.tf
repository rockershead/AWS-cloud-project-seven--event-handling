
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.event_handling_api.id

  depends_on = [
    aws_api_gateway_integration.lambda_integration_event_register
  ]


  # So that only when any of the API Gateway resources change, it will trigger a redeployment
  triggers = {
    redeployment = sha1(jsonencode([
      sha1(file("${path.module}/event_register_api_gateway.tf"))
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.event_handling_api.id
  stage_name    = "prod"
}