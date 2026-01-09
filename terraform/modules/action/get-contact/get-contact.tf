/*
  Creates the action
*/
resource "genesyscloud_integration_action" "get-contact" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  
  contract_input = jsonencode({
    "title" = "source",
    "type" = "object",
    "properties" = {
      "PHONE_NUMBER" = {
        "type" = "string"
      }
    }
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {
      "id" = {
        "type" = "string"
      },
      "success" = {
        "type" = "string"
      },
      "Id" = {
        "type" = "string"
      },
      "FirstName" = {
        "type" = "string"
      },
      "LastName" = {
        "type" = "string"
      },
      "mickelsen051599__Policy_Advisor__c" = {
        "type" = "string"
      },
      "mickelsen051599__Policy_Number__c" = {
        "type" = "string"
      },
      "mickelsen051599__Policy_Type__c" = {
        "type" = "string"
      },
      "mickelsen051599__Vehicle_Make_Model__c" = {
        "type" = "string"
      },
      "mickelsen051599__Vehicle_Year__c" = {
        "type" = "string"
      },
      "mickelsen051599__Account_Type__c" = {
        "type" = "string"
      },
      "mickelsen051599__Account_Number__c" = {
        "type" = "string"
      },
      "mickelsen051599__Balance__c" = {
        "type" = "string"
      },
      "mickelsen051599__Payment_Status__c" = {
        "type" = "string"
      },
      "mickelsen051599__Payment_Amount__c" = {
        "type" = "string"
      },
      "mickelsen051599__Payment_Due_Date__c" = {
        "type" = "string"
      },
      "Phone" = {
        "type" = "string"
      },
      "HomePhone" = {
        "type" = "string"
      },
      "MobilePhone" = {
        "type" = "string"
      },
      "OtherPhone" = {
        "type" = "string"
      },
      "Email" = {
        "type" = "string"
      },
      "MailingStreet" = {
        "type" = "string"
      },
      "MailingCity" = {
        "type" = "string"
      },
      "MailingState" = {
        "type" = "string"
      },
      "MailingPostalCode" = {
        "type" = "string"
      },
      "MailingCountry" = {
        "type" = "string"
      }
    }
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings
    request_url_template = "/services/data/v37.0/search/?q=$esc.url(\"FIND {$salesforce.escReserved($${input.PHONE_NUMBER}))} IN PHONE FIELDS RETURNING Contact(AccountId,Birthdate,CreatedDate,Description,Email,Fax,FirstName,HomePhone,Id,IsDeleted,LastName,LeadSource,mickelsen051599__Policy_Advisor__c,mickelsen051599__Policy_Number__c,mickelsen051599__Account_Type__c,mickelsen051599__Account_Number__c,mickelsen051599__Balance__c,mickelsen051599__Policy_Type__c,mickelsen051599__Vehicle_Make_Model__c,mickelsen051599__Vehicle_Year__c,mickelsen051599__Payment_Amount__c,mickelsen051599__Payment_Due_Date__c,mickelsen051599__Payment_Status__c,MailingAddress,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,MobilePhone,Name,OwnerId,Phone,Salutation,Title)\")"
    request_type         = "GET"
    request_template     = "$${input.rawRequest}"
    headers = {}
  }
  config_response {
    translation_map = {
      "contact" = "$.searchRecords"
    }
    translation_map_defaults = {}
    success_template = "$${contact}"
  }
}
