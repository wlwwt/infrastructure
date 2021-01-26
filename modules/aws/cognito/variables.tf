variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cognito_role_external_id" {
  type = string
}

variable "enabled_providers" {
  type    = list(string)
  default = []
}

variable "google_client_id" {
  type    = string
  default = ""
}

variable "google_client_secret" {
  type    = string
  default = ""
}

variable "facebook_client_id" {
  type    = string
  default = ""
}

variable "facebook_client_secret" {
  type    = string
  default = ""
}

variable "callback_urls" {
  type    = list(string)
  default = []
}

variable "logout_urls" {
  type    = list(string)
  default = []
}

variable "enable_mfa" {
  type    = bool
  default = true
}

variable "username_attributes" {
  type    = list(string)
  default = ["phone_number", "email"]
}

variable "user_groups" {
  type    = set(string)
  default = []
}

variable "post_confirmation_lambda_arn" {
  type    = string
  default = ""
}