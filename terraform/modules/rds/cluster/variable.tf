variable "name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "engine" {
  type = string
  default = "aurora-mysql"
}

variable "engine_version" {
  type = string
  default = "8.0.mysql_aurora.3.01.0"
}

variable "database_name" {
  type = string
}

variable "master_username" {
  type = string
}

variable "master_password" {
  type = string
}

variable "port" {
  type = string
}

variable "parameter_group_family" {
  type = string
  default = "aurora-mysql8.0"
}

