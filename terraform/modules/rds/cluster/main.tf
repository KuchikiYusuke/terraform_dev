resource "aws_db_subnet_group" "subnet_group" {
  name        = "${var.name}-subnet-group"
  description = "database-subnet-group"
  subnet_ids  = var.subnet_ids
}

####################################################
# RDS Cluster
####################################################

resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier = "${var.name}-cluster"

  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids

  engine = var.engine
  engine_version = var.engine_version

  database_name   = var.database_name
  master_username = var.master_username
  master_password = var.master_password
  port            = var.port

  skip_final_snapshot = true

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.parameter_group.name
}

####################################################
# RDS cluster config
####################################################

resource "aws_rds_cluster_parameter_group" "parameter_group" {
  name   = "${var.name}-cluster-parameter-group"
  # family = "aurora-mysql8.0"
  family = var.parameter_group_family

  parameter {
    name  = "time_zone"
    value = "Asia/Tokyo"
  }
}
