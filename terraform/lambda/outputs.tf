output "event_register_lambda_function_name"{
    value = aws_lambda_function.event_register_lambda.function_name
}

output "event_register_lambda_arn"{
    value = aws_lambda_function.event_register_lambda.invoke_arn
}