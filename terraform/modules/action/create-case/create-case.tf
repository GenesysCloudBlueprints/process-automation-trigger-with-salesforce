/*
  Creates the action
*/
resource "genesyscloud_integration_action" "create-case" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  
  contract_input = jsonencode({
    "title" = "source",
    "type" = "object",
    "properties" = {
      "description" = {
        "type" = "string"
      },
      "subject" = {
        "type" = "string"
      },
      "contactId" = {
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
      }
    }
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings
    request_url_template = "/services/data/v55.0/sobjects/Case/"
    request_type         = "POST"
    request_template     = "{\"ContactId\": \"$${input.contactId}\",\"Subject\": \"$${input.subject}\",\"Description\": \"$${input.description}\",\"Origin\":\"Alexa\"}"
    headers = {}
  }
  config_response {
    translation_map = {}
    translation_map_defaults = {}
    success_template = "$${rawResult}"
  }
}
