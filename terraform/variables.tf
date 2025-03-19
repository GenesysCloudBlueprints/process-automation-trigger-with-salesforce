variable "client_id" {
  type        = string
  description = "The OAuth (Client Credentails) Client ID to be used by Data Actions"
}

variable "client_secret" {
  type        = string
  description = "The OAuth (Client Credentails) Client Secret to be used by Data Actions"
}

variable "email" {
  type        = string
  description = "The Account Email address to be used by Groups"
}

variable "username" {
  type        = string
  description = "The username to use for Salesforce integration creation"
}

variable "password" {
  type        = string
  description = "The password to use for Salesforce integration creation"

variable "security_token" {
  type        = string
  description = "The security token to use for Salesforce integration creation"
}