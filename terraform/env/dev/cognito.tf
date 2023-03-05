module "cognito" {
  source = "../../modules/cognito"

  pool_name   = "${var.prefix}-${var.system}-cognito-pool"
  client_name = "${var.prefix}-${var.system}-cognito-client"
  domain      = "${var.prefix}-${var.system}"
  lambda_config = {
    pre_sign_up = module.lambda.lambda_arn
  }

  identity_providers = [
    {
      provider      = "Google"
      client_id     = data.aws_ssm_parameter.google_client_id.value
      client_secret = data.aws_ssm_parameter.google_client_secret.value
      scopes        = "profile email openid"
      attribute_mapping = {
        nickname = "name"
      },

      // Apple ログイン用に必要な属性
      // 設定しないとエラーになるため、nullを入れている
      team_id     = null
      key_id      = null
      private_key = null
    },
    {
      provider      = "Facebook"
      client_id     = data.aws_ssm_parameter.facebook_client_id.value
      client_secret = data.aws_ssm_parameter.facebook_client_secret.value
      scopes        = "public_profile email"
      attribute_mapping = {
        nickname = "first_name"
      }

      // Apple ログイン用に必要な属性
      // 設定しないとエラーになるため、nullを入れている
      team_id     = null
      key_id      = null
      private_key = null
    },
    {
      provider      = "LoginWithAmazon"
      client_id     = data.aws_ssm_parameter.amazon_client_id.value
      client_secret = data.aws_ssm_parameter.amazon_client_secret.value
      scopes        = "profile postal_code"
      attribute_mapping = {
        nickname = "name"
      }

      // Apple ログイン用に必要な属性
      // 設定しないとエラーになるため、nullを入れている
      team_id     = null
      key_id      = null
      private_key = null
    },
    {
      provider      = "SignInWithApple"
      client_id     = data.aws_ssm_parameter.apple_client_id.value
      client_secret = null
      team_id       = data.aws_ssm_parameter.apple_team_id.value
      key_id        = data.aws_ssm_parameter.apple_key_id.value
      private_key   = data.aws_ssm_parameter.apple_private_key.value
      scopes        = "name"
      attribute_mapping = {
        nickname = "firstName"
      }
    }
  ]
}

####################################################
# Create SSM Userpool ID
####################################################

resource "aws_ssm_parameter" "userpool_id" {
  name  = "${local.ssm_parameter_store_base}/userpool/id"
  type  = "String"
  value = module.cognito.cognito_user_pool_id
}