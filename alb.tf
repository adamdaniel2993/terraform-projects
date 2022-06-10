##################### Hygear LoadBalancer ####################

resource "aws_alb" "application_load_balancer" {
  name               = "${var.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.hygear-vpc.public_subnets
  security_groups    = [aws_security_group.load_balancer_security_group.id]

  tags = {
    Name        = "${var.app_name}-alb"
    Environment = var.env
  }
}


############## Target Groups hygear-Api ###############

resource "aws_lb_target_group" "api_target_group" {
  name        = "${var.app_name}-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.hygear-vpc.vpc_id

  health_check {
    healthy_threshold   = "5"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.app_name}-lb-tg"
    Environment = var.env
  }
}

resource "aws_lb_target_group" "api_target_group_database" {
  name        = "${var.app_name}-database-tg"
  port        = 5555
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.hygear-vpc.vpc_id

  health_check {
    healthy_threshold   = "5"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.app_name}-lb-tg"
    Environment = var.env
  }
}

################## Listener hygear API ############################


resource "aws_lb_listener" "api-listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_target_group.id
  }
}

resource "aws_lb_listener" "api-listener-database" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "5555"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_target_group_database.id
  }
}


################################################################################################################################3


##################### Hygear Frontend Loadbalancer ######################

resource "aws_alb" "frontend_load_balancer" {
  name               = "${var.frontend_name}-frontend"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.hygear-vpc.public_subnets
  security_groups    = [aws_security_group.load_balancer_security_group.id]

  tags = {
    Name        = "${var.frontend_name}-frontend"
    Environment = var.env
  }
}


############## Target Groups hygear-frontend ###############

resource "aws_lb_target_group" "frontend_target_group" {
  name        = "${var.frontend_name}-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.hygear-vpc.vpc_id

  health_check {
    healthy_threshold   = "5"
    interval            = "120"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "20"
    path                = "/"
    unhealthy_threshold = "4"
  }

  tags = {
    Name        = "${var.app_name}-lb-tg"
    Environment = var.env
  }
}

################## Listener hygear frontend ############################

resource "aws_lb_listener" "frontend-listener" {
  load_balancer_arn = aws_alb.frontend_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_target_group.id
  }
}
