variable "data_action_category" {
  type        = string
  description = "The Data Action category that is to be used in creation."
}

variable "get_contact_data_action_name" {
  type        = string
  description = "The Data Action name that is used for getting contact information by using the phone number."
}

variable "get_summary_data_action_name" {
  type        = string
  description = "The Data Action name that is used for getting the summary."
}

variable "create_case_data_action_name" {
  type        = string
  description = "The Data Action name that is used for creating a case on salesforce."
}

variable "support_queue" {
  type        = string
  description = "The support queue name to be used in the flow"
}
