
##

This project is to highlight the use of different AWS services to execute event handling.

- Take note event bridge pipe is a one to one connection and event bus can connect to many services at a time.Another thing is event bus cannot have  dynamodb as a source, only eventbridge can.so we have to use both together.