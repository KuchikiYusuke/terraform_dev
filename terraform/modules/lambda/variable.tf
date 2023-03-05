variable "name" {
  type = string
}

variable "role" {
  type = string
}

variable "image_uri" {
  type = string
}

variable "env_variables" {
  type = map(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "entry_point" {
  type = list(string)
}