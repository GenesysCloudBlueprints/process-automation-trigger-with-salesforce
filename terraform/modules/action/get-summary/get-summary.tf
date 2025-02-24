/*
  Creates the action
*/
resource "genesyscloud_integration_action" "create-hubspot-ticket" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "hs_pipeline" = {
        "type" = "string"
      },
      "hs_pipeline_stage" = {
        "type" = "string"
      },
      "hs_ticket_priority" = {
        "type" = "string"
      },
      "subject" = {
        "type" = "string"
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
    request_url_template = "https://api.hubapi.com/crm/v3/objects/tickets"
    request_type         = "POST"
    request_template     = "{\"properties\": {\"hs_pipeline\": \"$${input.hs_pipeline}\", \"hs_pipeline_stage\": \"$${input.hs_pipeline_stage}\", \"hs_ticket_priority\": \"$${input.hs_ticket_priority}\", \"subject\": \"$${input.subject}\" }   }"
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
