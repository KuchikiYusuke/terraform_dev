module "api_gateway" {
  source = "../../modules/api_gateway"

  api_name   = "${var.prefix}-${var.system}-api-gateway"
  link_name  = "${var.prefix}-${var.system}-vpc-link"
  stage_name = "${var.prefix}-${var.system}-api-stage"
  auth_name  = "${var.prefix}-${var.system}-api-auth"

  # auth_type = "COGNITO_USER_POOLS"
  auth_type   = "NONE"
  cognito_arn = module.cognito.cognito_arn

  // リクエスト送信先
  target_uri  = "https://${local.nlb_domain_name}"
  target_arns = [module.nlb.lb_arn]
}