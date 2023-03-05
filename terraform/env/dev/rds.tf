####################################################
# RDS SSM
####################################################

module "rds_cluster" {
  source = "../../modules/rds/cluster"

  name       = "${var.prefix}-${var.system}-rds"
  subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [
    module.api_rds_service_sg.security_group_id
  ]
  database_name   = data.aws_ssm_parameter.database_name.value
  master_username = data.aws_ssm_parameter.database_user.value
  master_password = data.aws_ssm_parameter.database_password.value
  port            = data.aws_ssm_parameter.database_port.value
}

module "rds_instance" {
  source = "../../modules/rds/instance"

  name                 = "${var.prefix}-${var.system}-rds"
  cluster_identifier   = module.rds_cluster.identifier_id
  engine               = module.rds_cluster.engine
  engine_version       = module.rds_cluster.engine_version
  db_subnet_group_name = module.rds_cluster.db_subnet_group_name
  instance_class       = "db.t3.medium" // 一番スペック低い。開発用
}

####################################################
# Create SSM DB url
####################################################

resource "aws_ssm_parameter" "database_url" {
  name  = "${local.ssm_parameter_store_base}/database/url"
  type  = "String"
  value = module.rds_cluster.endpoint
}