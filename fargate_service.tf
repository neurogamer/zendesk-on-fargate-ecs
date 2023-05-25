resource "aws_ecs_service" "ztm-task-service" {
  name            = "analytics-integrations-zendesk-ticket-mapper-service"
  task_definition = aws_ecs_task_definition.analytics-integrations-zendesk-ticket-mapper.arn
  cluster         = var.ecs_cluster_arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets  = var.task_subnets
  }

  }