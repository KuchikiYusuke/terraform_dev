output "target_group" {
  value = aws_lb_target_group.nlb_target
}

output "dns_name" {
  value = aws_lb.nlb.dns_name
}

output "zone_id" {
  value = aws_lb.nlb.zone_id
}

output "lb_arn" {
  value = aws_lb.nlb.arn
}