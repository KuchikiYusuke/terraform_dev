####################################################
# Route53 Host Zone
####################################################
data "aws_route53_zone" "host_domain" {
  name = data.aws_ssm_parameter.host_domain.value
}