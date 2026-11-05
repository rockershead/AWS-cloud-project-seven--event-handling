output "api_gateway_url" {
  value = "${aws_api_gateway_stage.example.invoke_url}/events"
}