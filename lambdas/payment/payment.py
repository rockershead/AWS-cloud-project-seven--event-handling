import json

def lambda_handler(event, context):
    print("Doing payment")
    print("Received event: ", event) 
    event_data = json.loads(json.loads(event["Records"][0]["body"])["Message"])["detail"]["dynamodb"]["NewImage"]["event"]["M"]
    print("Event data: ", event_data)