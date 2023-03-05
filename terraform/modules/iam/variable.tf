variable "name" {
  type = string
}

variable "identifier_list" {
  type = list(string)
}

variable "type" {
  type = string
}

variable "managed_policy_list" {
  default = []
  type = list(string)
}

variable "custom_policy_list" {
  default = []
  type = list(
    map(string)
  )
}