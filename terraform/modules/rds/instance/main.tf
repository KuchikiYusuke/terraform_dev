####################################################
# RDS Cluster Instance
####################################################

resource "aws_rds_cluster_instance" "rds_instance" {
  identifier         = "${var.name}-cluster-instance"
  # cluster_identifier = aws_rds_cluster.this.id
  cluster_identifier = var.cluster_identifier

  # engine = aws_rds_cluster.this.engine
  engine = var.engine
  # engine_version = aws_rds_cluster.this.engine_version
  engine_version = var.engine_version

  instance_class = var.instance_class
  # db_subnet_group_name = aws_rds_cluster.this.db_subnet_group_name
  db_subnet_group_name = var.db_subnet_group_name
}

