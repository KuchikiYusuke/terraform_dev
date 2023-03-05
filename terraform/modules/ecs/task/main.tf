resource "aws_ecs_task_definition" "ecs_task" {
  family                   = var.name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.role
  task_role_arn            = var.role
  container_definitions    = jsonencode([
    {
      name             = var.task_name
      image            = var.image
      secrets = var.secrets
      portMappings     = [{ containerPort : var.container_port }]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          awslogs-region : "ap-northeast-1"
          awslogs-group : aws_cloudwatch_log_group.ecs_log.name
          awslogs-stream-prefix : "ecs"
        }
      }
    }
  ])
}

####################################################
# ECS Task Container Log Groups
####################################################

resource "aws_cloudwatch_log_group" "ecs_log" {
  name              = "/ecs/${var.name}"
  retention_in_days = var.log_limit_days
}