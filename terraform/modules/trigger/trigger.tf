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
      "jsonPath" : "mediaType",
      "operator" : "In",
      "values" : ["UNKNOWN","VOICE","CHAT","EMAIL","CALLBACK","COBROWSE","VIDEO","SCREENSHARE","MESSAGE","INTERNALMESSAGE"]
    },
    {
      "jsonPath" : "direction",
      "operator" : "In",
      "values" : ["UNKNOWN","INBOUND","OUTBOUND"]
    },
    {
      "jsonPath" : "messageType",
      "operator" : "In",
      "values" : ["UNKNOWN","SMS","TWITTER","FACEBOOK","LINE","WHATSAPP","WEBMESSAGING","OPEN","INSTAGRAM","APPLE"]
    },
    {
      "jsonPath" : "ani",
      "operator" : "In",
      "values" : ["${var.ani}"]
    }
  ])
  event_ttl_seconds = 60
}