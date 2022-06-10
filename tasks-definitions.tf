############## hygear-API Task Definition ##################
resource "aws_ecs_task_definition" "hygear-api-task" {
  family = "${var.app_name}-task"

  container_definitions    = <<DEFINITION

    [
    {
      "name": "${var.app_name}-container",
      "image": "${aws_ecr_repository.hygear-api.repository_url}:${var.ecs_image_tag}",
      "entryPoint": [],
      "environment": [
        {
          "name": "POSTGRES_HOST",
          "value": "${aws_ssm_parameter.ssm_rds_address.value}"  
        },
        {
          "name": "ACCESS_TOKEN_EXPIRATION",
          "value": "15"  
        },
        {
          "name": "ACCESS_TOKEN_SECRET",
          "value": "fa7aea448b7e3148d8f96a4e6789b49fd1037245705f9d94165f40098c959fa59d2262c0f3b59acabe9f543b23ce70505a40ae3b20949fd3e61d4bd5b832b081"  
        },
        {
          "name": "REFRESH_TOKEN_SECRET",
          "value": "6755e93d99e34e3a1230abae280aa9952815e6b73a4dfa147e20391ce568b2e712d9cd1414c42bf054c1f0faefd242454c8c7474f9e5033d52503f8225c9722d7a034feae9f2951f4bbea025420bdb84452938da22e6daa494ecce8b154503213366b08a83001751f7443495fd6e2cc45855d23de30382b5e511ab59520eab6e"  
        },
        {
          "name": "POSTGRES_PASSWORD",
          "value": "${aws_ssm_parameter.ssm_rds_password.value}"
        },
        {
          "name": "POSTGRES_PORT",
          "value": "5432"  
        },
        {
          "name": "AWS_ACCESS_KEY_ID",
          "value": "AKIAVVJEPQOUELJWXBVA"  
        },
        {
          "name": "AWS_SECRET_ACCESS_KEY",
          "value": "3+kS5CdrRAVUhx+/INVmP92fYxNBR3t1PgD1hH49"  
        },
        {
          "name": "POSTGRES_USER",
          "value": "${aws_ssm_parameter.ssm_rds_user.value}"  
        },
        {
          "name": "POSTGRES_DB",
          "value": "${aws_ssm_parameter.db_name.value}"  
        },
        {
          "name": "DATABASE_URL",
          "value": "postgresql://hygearapi:${aws_ssm_parameter.ssm_rds_password.value}@${aws_db_instance.hygear_rds.endpoint}/POSTGRES_DB=${aws_db_instance.hygear_rds.db_name}?schema=public"  
        }
      ],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "${var.app_name}"
        }
      },
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        },
        {
          "containerPort": 5555,
          "hostPort": 5555
        }
      ],
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "2048"
  cpu                      = "1024"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn

  tags = {
    Name        = "${var.app_name}-ecs-td"
    Environment = var.env
  }
}
data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.hygear-api-task.family
}




############## hygear-frontend Task Definition ##################
resource "aws_ecs_task_definition" "hygear-frontend-task" {
  family = "${var.frontend_name}-task"

  container_definitions    = <<DEFINITION

    [
    {
      "name": "${var.frontend_name}-container",
      "image": "${aws_ecr_repository.hygear-frontend.repository_url}:${var.ecs_image_tag}",
      "entryPoint": [],
      "environment": [
        {
          "name": "AMPLIFY_REGION",
          "value": "${var.region}"  
        },
        {
          "name": "AMPLIFY_USER_POOL_ID",
          "value": "${aws_cognito_user_pool.hygear-cognito.id}"
        },
        {
          "name": "AMPLIFY_USER_POOL_WEB_CLIENT_ID",
          "value": "${aws_cognito_user_pool_client.client.id}"
        },
        {
          "name": "BACKEND_ENDPOINT",
          "value": "${aws_alb.application_load_balancer.dns_name}/api/v1"  
        }
      ],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "${var.frontend_name}"
        }
      },
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "2048"
  cpu                      = "1024"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn

  tags = {
    Name        = "${var.frontend_name}-ecs-td"
    Environment = var.env
  }
}
data "aws_ecs_task_definition" "main-frontend" {
  task_definition = aws_ecs_task_definition.hygear-frontend-task.family
}
