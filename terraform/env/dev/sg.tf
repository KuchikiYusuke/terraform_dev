####################################################
# EC2 Security Group
####################################################

module "api_ec2_service_sg" {
  source = "../../modules/sg"

  name        = "${var.prefix}-${var.system}-ec2-sg"
  description = "Security Group for EC2"
  vpc_id      = module.vpc.vpc_id

  // ssmで通信するため、ingressルール不要
}

####################################################
# Application Security Group
####################################################

module "api_ecs_service_sg" {
  source = "../../modules/sg"

  name        = "${var.prefix}-${var.system}-ecs-sg"
  description = "Security Group for ECS"
  vpc_id      = module.vpc.vpc_id

  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.private_subnets_cidr_blocks[0]]
}

####################################################
# RDS Security Group
####################################################

module "api_rds_service_sg" {
  source = "../../modules/sg"

  name        = "${var.prefix}-${var.system}-rds-sg"
  description = "Security Group for rds"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      source_security_group_id = module.api_ec2_service_sg.security_group_id
      rule                     = "mysql-tcp"
      description              = "Allow from EC2"
    },
    {
      source_security_group_id = module.api_ecs_service_sg.security_group_id
      rule                     = "mysql-tcp"
      description              = "Allow from ECS"
    },
    {
      source_security_group_id = module.api_lambda_service_sg.security_group_id
      rule                     = "mysql-tcp"
      description              = "Allow from Lambda"
    },
  ]
}

####################################################
# Lambda Security Group
####################################################

module "api_lambda_service_sg" {
  source = "../../modules/sg"

  name        = "${var.prefix}-${var.system}-lambda-sg"
  description = "Security Group for lambda"
  vpc_id      = module.vpc.vpc_id
}

