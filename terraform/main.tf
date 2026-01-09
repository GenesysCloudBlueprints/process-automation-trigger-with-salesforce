data "genesyscloud_user" "user" {
  email = var.email
}

// Create a Data Action integration
module "data_action" {
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "Genesys Cloud Data Actions"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
}

// Create a integration for SalesForce
module "integration" {
  source                          = "git::https://github.com/GenesysCloudDevOps/salesforce-data-actions-integration-module.git?ref=main"
  integration_name                = "Salesforce Data Actions Integration Name"
  salesforce_creds_username       = var.username
  salesforce_creds_password       = var.password
  salesforce_creds_security_token = var.security_token
}

// Get Contact Data Action
module "get_contact_data_action" {
  source             = "./modules/action/get-contact"
  action_name        = "Get Contact"
  action_category    = "${module.integration.integration_name}"
  integration_id     = "${module.integration.integration_id}"
}

// Get Summary Data Action
module "get_summary_data_action" {
  source             = "./modules/action/get-summary"
  action_name        = "Get Summary"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Create Case Data Action
module "create_case_data_action" {
  source             = "./modules/action/create-case"
  action_name        = "Create Case"
  action_category    = "${module.integration.integration_name}"
  integration_id     = "${module.integration.integration_id}"
}

// Configures the architect workflow
module "archy_flow" {
  source                           = "./modules/flow"
  data_action_category             = module.integration.integration_name
  get_contact_data_action_name     = module.get_contact_data_action.action_name
  get_summary_data_action_name     = module.get_summary_data_action.action_name
  create_case_data_action_name     = module.create_case_data_action.action_name
  support_queue                    = var.support_queue
  depends_on                       = [ module.data_action, module.integration, module.get_contact_data_action, module.get_summary_data_action, module.create_case_data_action ]
}

// Create a Trigger
module "trigger" {
  source          = "./modules/trigger"
  workflow_id     = module.archy_flow.flow_id
  user_id         = data.genesyscloud_user.user.id
  conversation_id = var.conversation_id
  ani             = var.ani
  depends_on      = [ module.archy_flow ]
}