variable "domain" {
  type = string
}

variable "a_record_alias_name" {
  type = string
}

variable "a_record_alias_zone_id" {
  type = string
}

variable "ns_record_zone_id" {
  type = string
}

variable "ns_record_ttl" {
  type = number
  default = 172800
}

####################################################
# Route53 zone
####################################################
resource "aws_route53_zone" "domain" {
  name = var.domain
}

####################################################
# Route53 A record
####################################################
resource "aws_route53_record" "a_record" {
  name    = aws_route53_zone.domain.name
  type    = "A"
  zone_id = aws_route53_zone.domain.zone_id
  alias {
    evaluate_target_health = true
    name = var.a_record_alias_name
    zone_id = var.a_record_alias_zone_id
  }
}

####################################################
# Route53 NS record
####################################################

resource "aws_route53_record" "ns_record" {
  name    = aws_route53_zone.domain.name
  type    = "NS"
  zone_id = var.ns_record_zone_id
  records = [
    aws_route53_zone.domain.name_servers[0],
    aws_route53_zone.domain.name_servers[1],
    aws_route53_zone.domain.name_servers[2],
    aws_route53_zone.domain.name_servers[3],
  ]
  ttl = var.ns_record_ttl
}


