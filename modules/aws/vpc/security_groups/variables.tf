variable "vpc_id" {
  type = string
}

variable "intranet_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "groups" {
  type = list(string)
}
