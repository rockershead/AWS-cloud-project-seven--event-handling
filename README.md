
##

This project is to highlight the use of different AWS services to implement an event driven architecture.In this case we will do it for a mock ecommerce platform to illustrate how this architecture will help to improve system performance.

The list of services being used are:
- Eventbridge
- Eventbus
- DynamoDB Streams
- SNS
- SQS
- Lambda

The architecture diagram can be seen below.

Data Flow:
- Event API is called to publish an event and store in dynmodb to activate the dynamodb stream.
- Data Stream flows to eventbridge then eventbus where it gets filtered by its event_type by configuring the rules.
- The filtered data flows to the SNS topic that complies with the rule.
- And the data is subscribed by many different sqs topics which in turn trigger the lambda services ampped to them.

Highlights:
-  Usage of many sqs topics subscribing to one SNS topic is an example of a fan out model
- Take note event bridge pipe is a one to one connection and event bus can connect to many services at a time.
- Event bus cannot have  dynamodb as a source, only eventbridge can. That is why we have to use both together.


Diagram:

<img width="1390" height="791" alt="e-commerce_event_handling_aws drawio" src="https://github.com/user-attachments/assets/1f1941d5-5037-435c-ab93-08f940ac419f" />