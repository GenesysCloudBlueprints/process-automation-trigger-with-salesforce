// Create a Data Action integration
module "data_action" {
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "Conversation Summary"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
}

// Get Contact Data Action
module "get_contact_data_action" {
  source             = "./modules/actions/get-contact"
  action_name        = "Get Contact"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Get Summary Data Action
module "get_summary_data_action" {
  source             = "./modules/actions/get-summary"
  action_name        = "Get Summary"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Create Case Data Action
module "create_case_data_action" {
  source             = "./modules/actions/create-case"
  action_name        = "Create Case"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Get Queue ID of queue
data "genesyscloud_routing_queue" "customer_queue" {
  name = var.customer_queue
}

// Configures the architect workflow
module "archy_flow" {
  source                           = "./modules/flow"
  data_action_category             = module.data_action.integration_name
  get_contact_action_name          = module.get_contact_action.action_name
  get_summary_data_action_name     = module.get_summary_data_action.action_name
  create_case_data_action_name     = module.create_case_data_action.action_name
  depends_on                       = [ module.data_action, module.get_contact_data_action, module.get_summary_data_action, module.create_case_data_action ]
}

// Create a Trigger
module "trigger" {
  source       = "./modules/trigger"
  workflow_id  = module.archy_flow.flow_id
  dnis         = var.dnis
  depends_on   = [ module.archy_flow ]
}