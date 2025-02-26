resource "genesyscloud_flow" "workflow" {
  filepath = "${path.module}/Mickelsen_Conversation_Summary_v11-0.yaml"
  file_content_hash = filesha256("${path.module}/Mickelsen_Conversation_Summary_v11-0.yaml")
  substitutions = {
    flow_name                      = "Mickelsen_Conversation_Summary"
    division                       = "Home"
    default_language               = "en-us"
    data_action_category           = var.data_action_category
    get_contact_data_action_name   = var.get_contact_data_action_name
    get_summary_data_action_name   = var.get_summary_data_action_name
    create_case_data_action_name   = var.create_case_data_action_name
    support_queue                  = var.support_queue
  }
}