terraform {
  required_version = "~> 1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.1.0"
    }
  }
}

locals {
  nlb_domain_name          = "nlb.${data.aws_ssm_parameter.host_domain.value}"
  ssm_parameter_store_base = "/${var.system}/${var.prefix}"
}

provider "aws" {
  region                   = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "bgm_dev"
  default_tags {
    tags = {
      application = var.system
      env         = var.prefix
      terraform   = true
    }
  }
}

# CloudFront向けのプロバイダー設定
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "bgm_dev"
  default_tags {
    tags = {
      application = var.system
      env         = var.prefix
      terraform   = true
    }
  }
}

####################################################
# Create SSM Region
####################################################

resource "aws_ssm_parameter" "region" {
  name  = "${local.ssm_parameter_store_base}/region"
  type  = "String"
  value = var.region
}
