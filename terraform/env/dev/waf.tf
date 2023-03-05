module "waf" {
  source = "../../modules/waf"

  name               = "${var.prefix}-${var.system}-waf"
  is_cloudfront_with = false
  connected_arn = module.api_gateway.api_gateway_stage_arn
  # aws_provider = provider.aws // CLOUDFRONTに接続する場合は、provider.aws.us_east_1
  enabled = true
}