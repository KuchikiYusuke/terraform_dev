variable "api_name" {
  type = string
}

variable "link_name" {
  type = string
}

variable "stage_name" {
  type = string
}

variable "target_uri" {
  type = string
}

variable "target_arns" {
  type = list(string)
}

variable "auth_name" {
  type = string
}

variable "cognito_arn" {
  type = string
}

variable "auth_type" {
  type = string
}

locals {
  is_auth = var.auth_type != "NONE"
}