variable "name" {
  type = string
}

variable "cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "asz" {
  type = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

variable "private_subnets" {
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "public_subnets" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "enable_nat_gateway" {
  type = bool
  default = true
}

variable "enable_vpn_gateway" {
  type = bool
  default = true
}

variable "enable_s3_endpoint" {
  default = false
}