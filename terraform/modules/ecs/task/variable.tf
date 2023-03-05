variable "name" {
  type = string
}

variable "cpu" {
  type = number
  default = 256
}

variable "memory" {
  type = number
  default = 512
}

variable "role" {
  type = string
}

variable "task_name" {
  type = string
}

variable "image" {
  type = string
}

variable "secrets" {
  type = list(map(string))
}

variable "container_port" {
  type = number
  default = 80
}

variable "log_limit_days" {
  type = number
  default = 30
}
