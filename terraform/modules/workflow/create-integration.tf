resource "genesyscloud_integration" "integration" {
  intended_state    = "DISABLED"
  integration_type  = "embedded-client-app"
  config {
    name = "hubspot_integration"
    properties      = jsonencode({
      "displayType" = "standalone",
      "sandbox"     = "allow-scripts,allow-same-origin,allow-forms,allow-modals",
      "url"         = join("", ["https://app.hubspot.com/contacts/", var.account_id, "/objects/0-5/views/all/list"])
      # Potential groups and queues filter (Need to look up the key name from integration type schema)
      "groups"      = [var.group_id]
    })
    advanced = jsonencode({})
    notes    = "Test config notes"
  }
}