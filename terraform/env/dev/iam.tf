####################################################
# policy for s3 access
####################################################
data "aws_iam_policy_document" "s3" {
  statement {
    actions = [
      "s3:*",
      "s3-object-lambda:*",
    ]

    resources = [
      module.s3_image.arn,
      "${module.s3_image.arn}/*"
    ]
  }
}

####################################################
# policy for cognito access
####################################################
data "aws_iam_policy_document" "cognito" {
  statement {
    actions = [
      "cognito-idp:*",
    ]

    resources = [
      module.cognito.cognito_arn,
    ]
  }
}

####################################################
# iam for ECS
####################################################

module "iam_ecs" {
  source = "../../modules/iam"

  name = "${var.prefix}-${var.system}-app-ecs-role"
  // role type
  type            = "Service"
  identifier_list = ["ecs-tasks.amazonaws.com"]

  // policy
  managed_policy_list = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
  ]
  custom_policy_list = [
    {
      name   = "kms_policy"
      policy = data.aws_iam_policy_document.kms_decrypt.json
    },
    {
      name   = "s3_image_policy"
      policy = data.aws_iam_policy_document.s3.json
    },
    {
      name   = "cognito_policy"
      policy = data.aws_iam_policy_document.cognito.json
    },
  ]
}

data "aws_iam_policy_document" "kms_decrypt" {
  statement {
    actions = [
      "kms:Decrypt"
    ]

    resources = [
      data.aws_ssm_parameter.database_password.arn
    ]
  }
}

####################################################
# iam for EC2
####################################################

module "iam_ec2" {
  source = "../../modules/iam"

  name = "${var.prefix}-${var.system}-bastionRDS-ec2-role"
  // role type
  identifier_list = ["ec2.amazonaws.com"]
  type            = "Service"

  // policy
  managed_policy_list = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
  custom_policy_list = [
    {
      name   = "s3_image_policy"
      policy = data.aws_iam_policy_document.s3.json
    },
    {
      name   = "cognito_policy"
      policy = data.aws_iam_policy_document.cognito.json
    },
  ]
}

####################################################
# iam for Lambda
####################################################

module "iam_lambda" {
  source = "../../modules/iam"

  name = "${var.prefix}-${var.system}-lambda-role"
  
  // role type
  identifier_list = ["lambda.amazonaws.com"]
  type            = "Service"

  // policy
  managed_policy_list = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
  ]
}

