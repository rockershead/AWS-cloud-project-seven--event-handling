import json
import boto3
import time
from datetime import datetime
import os
from aws_lambda_powertools.event_handler import APIGatewayRestResolver
from aws_lambda_powertools.utilities.typing import LambdaContext


app                                 = APIGatewayRestResolver()
MISSING_ENV_VARS_ERR_MSG            = "Missing env var(s)"
RESPONSE_CODE_JSON_KEY              = "status_code"
RESPONSE_BODY_JSON_KEY              = "body"
RESPONSE_CODE_INTERNAL_ERROR        = 500

def get_api_response(status_code, body):
    return {
        RESPONSE_CODE_JSON_KEY: status_code,
        RESPONSE_BODY_JSON_KEY: json.dumps(body) if type(body) == str else body
    }

def load_globals():
    """Sets global variables from environment variables and create aws boto3 client"""

    global table
    
   

    table_name = os.environ.get("TABLE_NAME")
    if table_name is None:
        return False
    
    dynamodb        = boto3.resource('dynamodb')
    table           = dynamodb.Table(table_name)
    
    
    
    return True


def get_request_body():
    """ Attempt to get request body """
    event_body = None
    try:
        event_body: dict = app.current_event.json_body
    except Exception as err:
        # API Gateway Body is None
        print(f"API Call missing request body, err: {err}")
    return event_body


@app.post("/events")
def add_event():
    event_body      = get_request_body()
    print(f"Received event body: {event_body}")
    expected_params = ["event_type","event"]
    if event_body is None:
        return ({
            'statusCode': 400,
            'body': json.dumps('Bad Request! Missing body')
        })
    
    if not all(param in event_body for param in expected_params):
        return ({
            'statusCode': 400,
            'body': json.dumps('Bad Request! Missing body parameters.Make sure body has event_type and event.')
        })
    
    event_type          = event_body.get("event_type")
    last_checked_in_ts  = int(time.time() * 1000)
    event               = event_body.get("event")

    item = {
        'event_type': event_type,
        'last_checked_in_ts': str(last_checked_in_ts),
        'event': event,
       
    }

    try:

        table.put_item(Item=item)

        return ({
            'statusCode': 200,
            'body': json.dumps('Event successfully added')
        })

    except Exception as e:
        return ({
            'statusCode': 500,
            'body': json.dumps(f'Error adding event: {str(e)}')
        })



def lambda_handler(event: dict, context: LambdaContext):
    if not load_globals():
        print(MISSING_ENV_VARS_ERR_MSG)
        return {
            "body": json.dumps(get_api_response(RESPONSE_CODE_INTERNAL_ERROR, MISSING_ENV_VARS_ERR_MSG))
        }
    return app.resolve(event, context)
