variable "health_check" {
  default = {
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    path                = "/health"
  }
  description = "Target group health check, for LB to assess service health"
  type = object({
    port                = string
    protocol            = string
    healthy_threshold   = number
    unhealthy_threshold = number
    interval            = number
    path                = string
  })
}

variable "stickiness" {
  default     = null
  description = "Stickiness session enabled."
  type        = any
}

variable "name" {
  type = string
}

variable "lb_type" {
  type = string
  default = "network"
}

variable "is_internal" {
  type = bool
  default = true
}

variable "subnet_ids" {
  type = list(string)
}

variable "target_port" {
  default = {
    port        = 80
    protocol    = "TCP"
    target_type = "ip"
  }
  type = object({
    port        = number
    protocol    = string
    target_type = string
  })
}

variable "target_vpc_id" {
  type = string
}

variable "listener_port" {
  default = {
    port     = 443
    protocol = "TLS"
  }
  type = object({
    port     = number
    protocol = string
  })
}

variable "listener_certificate_arn" {
  type = string
}

variable "target_prefix" {
  type = string
}

