########################################
# LB
########################################

// API Gateway, VPC Linkに接続されていると、設定変更できない
// 設定変更したい場合は、一旦API Gatewayを削除する必要あり
resource "aws_lb" "nlb" {
  name               = var.name
  load_balancer_type = var.lb_type
  internal = var.is_internal
  subnets = var.subnet_ids
}

########################################
# LB target
########################################

resource "aws_lb_target_group" "nlb_target" {
  name_prefix = var.target_prefix
  port        = var.target_port.port
  protocol    = var.target_port.protocol
  target_type = var.target_port.target_type
  vpc_id      = var.target_vpc_id

  health_check {
    healthy_threshold   = var.health_check.healthy_threshold
    interval            = var.health_check.interval
    port                = var.health_check.port
    protocol            = var.health_check.protocol
    unhealthy_threshold = var.health_check.unhealthy_threshold
    path                = var.health_check.path
  }

  dynamic "stickiness" {
    for_each = var.stickiness != null ? toset([var.stickiness]) : []
    content {
      enabled = lookup(stickiness.value, "enabled", false)
      type    = lookup(stickiness.value, "type", "lb_cookie")
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

########################################
# LB listener
########################################

resource "aws_lb_listener" "nlb_lister" {
  depends_on        = [aws_lb_target_group.nlb_target]
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.listener_port.port
  protocol          = var.listener_port.protocol

  default_action {
    target_group_arn = aws_lb_target_group.nlb_target.arn
    type             = "forward"
  }
  certificate_arn = var.listener_certificate_arn
}