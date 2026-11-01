resource "aws_sns_topic" "checkout_topic" {
    name = var.event_handling_sns_checkout_topic
   
}






// permissions and policies to push to sqs




// add subscription for the checkout topic