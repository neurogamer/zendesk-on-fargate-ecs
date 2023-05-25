resource "aws_cloudwatch_log_group" "ztm_logs" {
  name = "/ecs/${var.env}-analytics-integrations-zendesk-ticket-mapper"
}

resource "aws_ecs_task_definition" "analytics-integrations-zendesk-ticket-mapper" {
  family                   = "${var.env}-analytics-integrations-zendesk-ticket-mapper"
  execution_role_arn       = "arn:aws:iam::${var.acc_number}:role/ecsTaskExectionRole-ZTM-${var.env}"
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  depends_on               = [aws_iam_role.iam_role_for_ztm, aws_ssm_parameter.zendesk_token, aws_ssm_parameter.db_password, aws_cloudwatch_log_group.ztm_logs, aws_rds_cluster.ztm_db_cluster]
  requires_compatibilities = ["FARGATE"]
  container_definitions = <<DEFINITION
[
{
    "image": "${var.container_image}",
    "name": "zendesk-ticket-mapper",
    "logConfiguration": {
       "logDriver": "awslogs",
       "options": {
          "awslogs-region": "${var.region}",
          "awslogs-group": "/ecs/${var.env}-analytics-integrations-zendesk-ticket-mapper",
          "awslogs-stream-prefix": "ecs"
       }
    },
    "secrets": [
       {
          "name": "db_password",
          "valueFrom": "arn:aws:ssm:${var.region}:${var.acc_number}:parameter/${var.env}-ztm/db_password"
       },
       {
          "name": "zendesk_token",
          "valueFrom": "arn:aws:ssm:${var.region}:${var.acc_number}:parameter/${var.env}-ztm/zendesk_token"
       }
    ],
    "environment": [
       {
          "name": "db_host",
          "value": "${aws_rds_cluster.ztm_db_cluster.endpoint}"
       },
       {
          "name": "db_schema",
          "value": "${var.db_database_name}"
       },
       {
          "name": "db_username",
          "value": "${var.db_username}"
       },
       {
          "name": "zendesk_hostname",
          "value": "${var.zendesk_hostname}"
       },
       {
          "name": "zendesk_username",
          "value": "${var.zendesk_username}"
       }
    ]
 }
]
DEFINITION
}
