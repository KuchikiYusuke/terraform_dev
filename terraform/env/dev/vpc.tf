# ####################################################
# # VPC
# ####################################################

module "vpc" {
  source = "../../modules/vpc"

  name               = "${var.prefix}-${var.system}-vpc"
  enable_s3_endpoint = true
}