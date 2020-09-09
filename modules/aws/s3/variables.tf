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