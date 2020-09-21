variable "name" {
  type = string
}
variable "app_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "acl" {
  type        = string
  default     = "private"
  description = "The ACL to apply. Set to `private` to avoid exposing sensitive information."
}
variable "versioning_enabled" {
  type        = bool
  default     = false
  description = "A state of versioning (keeping multiple variants of an object in the same bucket)"
}
variable "encryption_enabled" {
  type        = bool
  default     = false
  description = "Bool to control if bucket encryption is enabled."
}
variable "sse_algorithm" {
  type        = string
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms."
}
variable "kms_master_key_arn" {
  type        = string
  default     = ""
  description = "The AWS KMS master key ID used for the SSE-KMS encryption. Used only if algorithm is aws:kms"
}