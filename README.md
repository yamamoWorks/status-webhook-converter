# MuleSoft Status Webhook Converter
This is a converter for webhook of status.mulesoft.com.  
Currently, only Teams connector is supported.

## Usage
1. Deploy this application.
2. Setup the webhook connector on Teams, and copy the generated url.  
https://outlook.office.com/webhook/xxxxxxxxxxxxxxxx/IncomingWebhook/xxxxxxxxxxxxxxxx
3. Assemble url for registering.  
http://{this-app}.cloudhub.io/**teams**/outlook.office.com/webhook/xxxxxxxxxxxxxxxx/IncomingWebhook/xxxxxxxxxxxxxxxx
4. Subscribe webhook on status.mulesoft.com with this url.
