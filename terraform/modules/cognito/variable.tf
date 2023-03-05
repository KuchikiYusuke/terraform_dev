variable "pool_name" {
  type    = string
}

variable "client_name" {
  type    = string
}

variable "client_callback_urls" {
  type = list(string)
  default = ["http://localhost:8000"]
}

variable "domain" {
  type = string
}

variable "identity_providers" {}

variable "auto_verified_attributes" {
  type = list(string)
  default = ["email"]
}

variable "is_allowed_oauth_flows" {
  type = bool
  default = true
}

variable "allowed_oauth_flows" {
  type = list(string)
  default = ["code"]
}

variable "allowed_oauth_scopes" {
  type = list(string)
  default = ["email", "openid", "profile"]
}

variable "lambda_config" {
  type = map(string)
  default = {}
}

variable "lambda_config_create_auth_challenge" {
  description = "The ARN of the lambda creating an authentication challenge."
  type        = string
  default     = null
}

variable "lambda_config_custom_message" {
  description = "A custom Message AWS Lambda trigger."
  type        = string
  default     = null
}

variable "lambda_config_define_auth_challenge" {
  description = "Defines the authentication challenge."
  type        = string
  default     = null
}

variable "lambda_config_post_authentication" {
  description = "A post-authentication AWS Lambda trigger"
  type        = string
  default     = null
}

variable "lambda_config_post_confirmation" {
  description = "A post-confirmation AWS Lambda trigger"
  type        = string
  default     = null
}

variable "lambda_config_pre_authentication" {
  description = "A pre-authentication AWS Lambda trigger"
  type        = string
  default     = null
}
variable "lambda_config_pre_sign_up" {
  description = "A pre-registration AWS Lambda trigger"
  type        = string
  default     = null
}

variable "lambda_config_pre_token_generation" {
  description = "Allow to customize identity token claims before token generation"
  type        = string
  default     = null
}

variable "lambda_config_user_migration" {
  description = "The user migration Lambda config type"
  type        = string
  default     = null
}

variable "lambda_config_verify_auth_challenge_response" {
  description = "Verifies the authentication challenge response"
  type        = string
  default     = null
}

variable "lambda_config_kms_key_id" {
  description = "The Amazon Resource Name of Key Management Service Customer master keys. Amazon Cognito uses the key to encrypt codes and temporary passwords sent to CustomEmailSender and CustomSMSSender."
  type        = string
  default     = null
}