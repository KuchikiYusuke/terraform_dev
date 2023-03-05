# DB接続情報
data "aws_ssm_parameter" "database_name" {
  name = "${local.ssm_parameter_store_base}/database/name"
}

data "aws_ssm_parameter" "database_user" {
  name = "${local.ssm_parameter_store_base}/database/user"
}

data "aws_ssm_parameter" "database_password" {
  name = "${local.ssm_parameter_store_base}/database/password"
}

data "aws_ssm_parameter" "database_port" {
  name = "${local.ssm_parameter_store_base}/database/port"
}

data "aws_ssm_parameter" "host_domain" {
  name = "${local.ssm_parameter_store_base}/domain"
}

# ECS環境
data "aws_ssm_parameter" "env" {
  name = "${local.ssm_parameter_store_base}/env"
}

# ECRリポジトリ
data "aws_ssm_parameter" "ecr_repository" {
  name = "${local.ssm_parameter_store_base}/ecr/repository"
}

# Lambda ECRリポジトリ
data "aws_ssm_parameter" "lambda_repository" {
  name = "${local.ssm_parameter_store_base}/lambda/repository"
}

// Google ソーシャルログイン情報
data "aws_ssm_parameter" "google_client_id" {
  name = "${local.ssm_parameter_store_base}/oidc/google/client_id"
}

data "aws_ssm_parameter" "google_client_secret" {
  name = "${local.ssm_parameter_store_base}/oidc/google/client_secret"
}

// Facebook ソーシャルログイン情報
data "aws_ssm_parameter" "facebook_client_id" {
  name = "${local.ssm_parameter_store_base}/oidc/facebook/client_id"
}

data "aws_ssm_parameter" "facebook_client_secret" {
  name = "${local.ssm_parameter_store_base}/oidc/facebook/client_secret"
}

// Amazon ソーシャルログイン情報
data "aws_ssm_parameter" "amazon_client_id" {
  name = "${local.ssm_parameter_store_base}/oidc/amazon/client_id"
}

data "aws_ssm_parameter" "amazon_client_secret" {
  name = "${local.ssm_parameter_store_base}/oidc/amazon/client_secret"
}

// Apple ソーシャルログイン情報
data "aws_ssm_parameter" "apple_client_id" {
  name = "${local.ssm_parameter_store_base}/oidc/apple/client_id"
}

data "aws_ssm_parameter" "apple_team_id" {
  name = "${local.ssm_parameter_store_base}/oidc/apple/team_id"
}

data "aws_ssm_parameter" "apple_key_id" {
  name = "${local.ssm_parameter_store_base}/oidc/apple/key_id"
}

data "aws_ssm_parameter" "apple_private_key" {
  name = "${local.ssm_parameter_store_base}/oidc/apple/private_key"
}

