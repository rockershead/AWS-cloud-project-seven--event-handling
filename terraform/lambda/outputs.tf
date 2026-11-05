output "event_register_lambda_function_name"{
    value = aws_lambda_function.event_register_lambda.function_name
}

output "event_register_lambda_arn"{
    value = aws_lambda_function.event_register_lambda.invoke_arn
}

output "account_id" {
    value = data.aws_caller_identity.current_caller_for_event_register_lambda.account_id
}