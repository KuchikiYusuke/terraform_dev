resource "aws_cognito_user_pool" "users" {
  name                     = var.pool_name
  auto_verified_attributes = var.auto_verified_attributes
  lambda_config {
    create_auth_challenge          = lookup(var.lambda_config, "create_auth_challenge", var.lambda_config_create_auth_challenge)
    custom_message                 = lookup(var.lambda_config, "custom_message", var.lambda_config_custom_message)
    define_auth_challenge          = lookup(var.lambda_config, "define_auth_challenge", var.lambda_config_define_auth_challenge)
    post_authentication            = lookup(var.lambda_config, "post_authentication", var.lambda_config_post_authentication)
    post_confirmation              = lookup(var.lambda_config, "post_confirmation", var.lambda_config_post_confirmation)
    pre_authentication             = lookup(var.lambda_config, "pre_authentication", var.lambda_config_pre_authentication)
    pre_sign_up                    = lookup(var.lambda_config, "pre_sign_up", var.lambda_config_pre_sign_up)
    pre_token_generation           = lookup(var.lambda_config, "pre_token_generation", var.lambda_config_pre_token_generation)
    user_migration                 = lookup(var.lambda_config, "user_migration", var.lambda_config_user_migration)
    verify_auth_challenge_response = lookup(var.lambda_config, "verify_auth_challenge_response", var.lambda_config_verify_auth_challenge_response)
    kms_key_id                     = lookup(var.lambda_config, "kms_key_id", var.lambda_config_kms_key_id)
  }
}

resource "aws_cognito_identity_provider" "provider" {
  for_each = { for i in var.identity_providers : i.provider => i }
  user_pool_id  = aws_cognito_user_pool.users.id
  provider_name = each.value.provider
  provider_type = each.value.provider

  provider_details = {
    authorize_scopes = each.value.scopes
    client_id        = each.value.client_id
    client_secret    = each.value.client_secret

    team_id     = each.value.team_id
    key_id      = each.value.key_id
    private_key = each.value.private_key

  }
  attribute_mapping = each.value.attribute_mapping

  lifecycle {
    ignore_changes = [provider_details, attribute_mapping]
  }
}

resource "aws_cognito_user_pool_client" "cognito" {
  depends_on = [aws_cognito_user_pool.users, aws_cognito_identity_provider.provider]
  name                                 = var.client_name
  user_pool_id                         = aws_cognito_user_pool.users.id
  supported_identity_providers         = var.identity_providers[*].provider
  allowed_oauth_flows_user_pool_client = var.is_allowed_oauth_flows
  allowed_oauth_flows                  = var.allowed_oauth_flows
  allowed_oauth_scopes                 = var.allowed_oauth_scopes
  callback_urls                        = var.client_callback_urls
  logout_urls                          = []
  read_attributes                      = []
  write_attributes                     = []
  explicit_auth_flows                  = []
  generate_secret                      = true
}

resource "aws_cognito_user_pool_domain" "custom" {
  domain       = var.domain
  user_pool_id = aws_cognito_user_pool.users.id
}