output "endpoint" {
  value = aws_rds_cluster.rds_cluster.endpoint
}

output "identifier_id" {
  value = aws_rds_cluster.rds_cluster.id
}

output "engine" {
  value = aws_rds_cluster.rds_cluster.engine
}

output "engine_version" {
  value = aws_rds_cluster.rds_cluster.engine_version
}

output "db_subnet_group_name" {
  value = aws_rds_cluster.rds_cluster.db_subnet_group_name
}
