// Create a Data Action integration
module "data_action" {
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "HubSpot Interaction"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
}

// Create Case Data Action
module "create-case" {
  source             = "./modules/actions/create-case"
  action_name        = "Create Case"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Get Summary Data Action
module "get-summary" {
  source             = "./modules/actions/get-summary"
  action_name        = "Get Summary"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}
