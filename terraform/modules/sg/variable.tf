variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_rules" {
  type = list(string)
  default = []
}

variable "ingress_cidr_blocks" {
  type = list(string)
  default = []
}

variable "ingress_with_source_security_group_id" {
  type = list(map(string))
  default = []
}

variable "egress_rules" {
  type = list(string)
  default = ["all-all"]
}

