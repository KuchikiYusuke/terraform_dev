module "lambda" {
  source = "../../modules/lambda"

  name = "${var.prefix}-${var.system}-user-create-lambda"
  role = module.iam_lambda.role_arn
  image_uri = data.aws_ssm_parameter.lambda_repository.value
  env_variables = {
    TOKYOBGM_DB_NAME = data.aws_ssm_parameter.database_name.value
    TOKYOBGM_DB_USER = data.aws_ssm_parameter.database_user.value
    TOKYOBGM_DB_PASSWORD = data.aws_ssm_parameter.database_password.value
    TOKYOBGM_DB_PORT = data.aws_ssm_parameter.database_port.value
    TOKYOBGM_DB_HOST = aws_ssm_parameter.database_url.value
  }
  subnet_ids = module.vpc.private_subnets
  security_group_ids = [module.api_lambda_service_sg.security_group_id]
  entry_point = ["/main"]
}