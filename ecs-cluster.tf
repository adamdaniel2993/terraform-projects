
resource "aws_ecs_cluster" "hygear-cluster" {
  name = "${local.prefix}-cluster"
  tags = {
    Name        = "${var.app_name}-ecs"
    Environment = var.env

  }
}

####### Cloudwatch log group for ecs logs #####
resource "aws_cloudwatch_log_group" "log-group" {
  name = "${local.prefix}-logs"

  tags = {
    Application = var.app_name
    Environment = var.env
  }
}



