################ hygear API ECS Service ###########################

resource "aws_ecs_service" "api-ecs-service" {
  name                 = "${var.app_name}-ecs-service"
  cluster              = aws_ecs_cluster.hygear-cluster.id
  task_definition      = "${aws_ecs_task_definition.hygear-api-task.family}:${max(aws_ecs_task_definition.hygear-api-task.revision, data.aws_ecs_task_definition.main.revision)}"
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets          = module.hygear-vpc.public_subnets
    assign_public_ip = true
    security_groups = [
      aws_security_group.hygear-service-sg.id,
      aws_security_group.load_balancer_security_group.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.api_target_group.arn
    container_name   = "${var.app_name}-container"
    container_port   = 3000
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.api_target_group_database.arn
    container_name   = "${var.app_name}-container"
    container_port   = 5555
  }

  depends_on = [aws_lb_listener.api-listener]
}


############## Hygear Frontend ####################################################
resource "aws_ecs_service" "frontend-ecs-service" {
  name                 = "${var.frontend_name}-ecs-service"
  cluster              = aws_ecs_cluster.hygear-cluster.id
  task_definition      = aws_ecs_task_definition.hygear-frontend-task.id
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets          = module.hygear-vpc.public_subnets
    assign_public_ip = true
    security_groups = [
      aws_security_group.hygear-service-sg.id,
      aws_security_group.load_balancer_security_group.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_target_group.arn
    container_name   = "${var.frontend_name}-container"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.api-listener]
}