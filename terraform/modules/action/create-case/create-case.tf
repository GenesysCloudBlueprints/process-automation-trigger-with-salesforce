/*
  Creates the action
*/
resource "genesyscloud_integration_action" "create-workitem" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  
  contract_input = jsonencode({
    "title" = "source",
    "type" = "object",
    "properties" = {
      "name": {
        "type": "string"
      },
      "priority": {
        "type": "integer"
      },
      "workbinId": {
        "type": "string"
      },
      "typeId": {
        "type": "string"
      },
      "casetype_text": {
        "type": "string"
      },
      "customername_text": {
        "type": "string"
      },
      "customernumber_text": {
        "type": "string"
      },
      "memo_longtext": {
        "type": "string"
      },
      "hb_ticketid": {
        "type": "string"
      },
      "externalcontactid": {
        "type": "string"
      },
      "hb_url": {
        "type": "string"
      }
    }
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {
      "id" = {
        "type": "string"
      }
    }
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/taskmanagement/workitems"
    request_type         = "POST"
    request_template     = "{\"properties\": {\"name\": \"$${input.name}\" ,  \"priority\": $${input.priority}, \"workbinId\": \"$${input.workbinId}\", \"typeId\":  \"$${input.typeId}\", \"externalContactId\": \"$${input.externalcontactid}\"  ,\"customFields\" : {\"casetype_text\": \"$${input.casetype_text}\" , \"customername_text\": \"$${input.customername_text}\" , \"customernumber_text\": \"$${input.customernumber_text}\", \"memo_longtext\": \"$${input.memo_longtext}\" , \"hb_ticketid_text\": \"$${input.hb_ticketid}\", \"hb_url_url\": \"$${input.hb_url}\"}}"
    headers = {
      "Authorization": "${var.bearer_token}",
      "Content-Type": "application/json"
    }
  }
  config_response {
    translation_map = {}
    translation_map_defaults = {}
    success_template = "$${rawResult}"
  }
}
