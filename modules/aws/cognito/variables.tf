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
  type        = list(string)
  default     = []
  description = "The list of enabled providers to be included in the pool: 'Google' and/or 'Facebook'"

  validation {
    condition = alltrue([
      for p in var.enabled_providers : contains(["Google", "Facebook"], p)
    ])
    error_message = "The allowed values are 'Google' and 'Facebook'."
  }
}

variable "google_client_id" {
  type        = string
  default     = ""
  description = "The Google client ID. Used only if enabled_providers contains 'Google'"
}

variable "google_client_secret" {
  type        = string
  default     = ""
  description = "The Google client secret. Used only if enabled_providers contains 'Google'"
}

variable "facebook_client_id" {
  type        = string
  default     = ""
  description = "The Facebook client ID. Used only if enabled_providers contains 'Facebook'"
}

variable "facebook_client_secret" {
  type        = string
  default     = ""
  description = "The Facebook client secret. Used only if enabled_providers contains 'Facebook'"
}

variable "callback_urls" {
  type        = list(string)
  default     = []
  description = "The enabled URLs where the user can be redirected after sign-in/signup with external providers. Used only if enabled_providers is not empty"
}

variable "logout_urls" {
  type        = list(string)
  default     = []
  description = "The enabled URLs where the user can be redirected after logout with external providers. Used only if enabled_providers is not empty"
}

variable "enable_mfa" {
  type        = bool
  default     = true
  description = "Enable MFA for all users in the pool. User must have a validated phone_number."
}

variable "mfa_methods" {
  type        = list(string)
  default     = ["SMS", "TOTP"]
  description = "Method to user for MFA. 'SMS' (text messages) or 'TOTP' (time-based one-time). Used only if enable_mfa is true"

  validation {
    condition = alltrue([
      for p in var.mfa_methods : contains(["SMS", "TOTP"], p)
    ])
    error_message = "The allowed values are 'SMS' and 'TOTP'."
  }
}

variable "username_attributes" {
  type        = list(string)
  default     = ["phone_number", "email"]
  description = "Attributes that a user can use as username."

  validation {
    condition = alltrue([
      for p in var.username_attributes : contains(["phone_number", "email"], p)
    ])
    error_message = "The allowed values are 'phone_number' and 'email'."
  }
}

variable "user_groups" {
  type    = set(string)
  default = []
}

variable "post_confirmation_lambda_arn" {
  type    = string
  default = ""

  description = "The lambda function that will be triggered after user post confirmation."
}