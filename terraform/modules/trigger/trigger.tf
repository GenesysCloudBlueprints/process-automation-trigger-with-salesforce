resource "genesyscloud_processautomation_trigger" "trigger" {
  name       = "Disconnected Call Trigger"
  topic_name = "v2.detail.events.conversation.{id}.acw"
  enabled    = true
  target {
    id   = var.workflow_id
    type = "Workflow"
    workflow_target_settings {
      data_format = "TopLevelPrimitives"
    }
  }
  match_criteria = jsonencode([
    {
      "jsonPath" : "userId",
      "operator" : "Equal",
      "value"    : var.user_id
    }
  ])
  event_ttl_seconds = 60
}