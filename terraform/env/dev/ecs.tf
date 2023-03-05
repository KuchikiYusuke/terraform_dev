####################################################
# ECS Cluster
####################################################
module "cluster" {
  source = "../../modules/ecs/cluster"
  name   = "${var.prefix}-${var.system}-app-ecs-cluster"
}

####################################################
# ECS Task Definition
####################################################
module "task" {
  source = "../../modules/ecs/task"

  name      = "${var.prefix}-${var.system}-app-ecs-task"
  role      = module.iam_ecs.role_arn
  task_name = "${var.prefix}-${var.system}-app-ecs-task-container"
  image     = data.aws_ssm_parameter.ecr_repository.value
  secrets = [
    {
      name : "TOKYOBGM_DB_NAME"
      valueFrom : data.aws_ssm_parameter.database_name.arn
    },
    {
      name : "TOKYOBGM_DB_USER"
      valueFrom : data.aws_ssm_parameter.database_user.arn
    },
    {
      name : "TOKYOBGM_DB_PASSWORD"
      valueFrom : data.aws_ssm_parameter.database_password.arn
    },
    {
      name : "TOKYOBGM_DB_PORT"
      valueFrom : data.aws_ssm_parameter.database_port.arn
    },
    {
      name : "TOKYOBGM_DB_HOST"
      valueFrom : aws_ssm_parameter.database_url.arn
    },
    {
      name : "TOKYOBGM_ENV"
      valueFrom : data.aws_ssm_parameter.env.arn
    },
    {
      name : "TOKYOBGM_USERPOOL_ID"
      valueFrom : aws_ssm_parameter.userpool_id.arn
    },
    {
      name : "TOKYOBGM_REGION"
      valueFrom : aws_ssm_parameter.region.arn
    },
  ]
}

####################################################
# ECS Service
####################################################
module "service" {
  source = "../../modules/ecs/service"

  name       = "${var.prefix}-${var.system}-app-ecs-service"
  cluster_id = module.cluster.id
  task_arn   = module.task.task_arn
  subnets = [
    module.vpc.private_subnets[0]
  ]
  security_groups = [
    module.api_ecs_service_sg.security_group_id
  ]
  target_group_arn = module.nlb.target_group.arn
  container_name   = "${var.prefix}-${var.system}-app-ecs-task-container"
}