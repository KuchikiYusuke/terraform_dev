####################################################
# Import Host domain Wildcard ACM
####################################################

data "aws_acm_certificate" "host_domain_wc_acm" {
  domain = local.nlb_domain_name
}

module "nlb" {
  source = "../../modules/nlb"

  name = "${var.prefix}-${var.system}-nlb"

  subnet_ids    = [module.vpc.private_subnets[0]]
  target_vpc_id = module.vpc.vpc_id
  target_prefix = "nlb"

  listener_certificate_arn = data.aws_acm_certificate.host_domain_wc_acm.arn
}

module "route53" {
  source = "../../modules/route53"

  domain = local.nlb_domain_name

  a_record_alias_name    = module.nlb.dns_name
  a_record_alias_zone_id = module.nlb.zone_id

  ns_record_zone_id = data.aws_route53_zone.host_domain.id
}
