# Process Automation Trigger with SalesForce

This blueprint implements a Process Automation Trigger that can be used for creating a case on SalesForce. When it is triggered, it will go through an Inbound Flow to collect the Copilot Summarization and create a case on SalesForce. To obtain the summary, an API will be called using the Conversation ID supplied from the trigger once the conversation is wrapped up. Finally, after retrieving the summary we can insert a record into SalesForce.

![Process Automation Trigger with SalesForce](blueprint/images/overview.png "Process Automation Trigger with SalesForce")