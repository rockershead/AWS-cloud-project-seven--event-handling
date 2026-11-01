resource "aws_sns_topic" "order_shipped_topic" {
    name = var.event_handling_sns_order_shipped_topic
   
}