variable "name" {
  type = string
}

variable "cluster_identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
  default = "db.t3.medium" // TODO 本番用に別クラスに変える
}

variable "db_subnet_group_name" {
  type = string
}
