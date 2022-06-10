locals {
  db_name = "${local.prefix}-rds"
  db_user = var.app_name
}

resource "random_password" "rds_master_password" {
  length  = 24
  special = false
  upper   = true
  number  = true
  lower   = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${local.prefix}-rds-subnet-group"
  subnet_ids = module.hygear-vpc.private_subnets

  tags = {
    Name        = "rds-subnet group"
    Environment = local.environment
  }
}

resource "aws_db_instance" "hygear_rds" {
  identifier           = "${local.prefix}-db"
  engine               = "postgres"
  engine_version       = "11.13"
  instance_class       = var.instance_db_class // "db.t3.micro"
  name                 = "hygeardev"
  username             = "hygearapi"                                #local.db_user //"foo"
  password             = random_password.rds_master_password.result #random_password.rds_master_password.result  //"foobarbaz"
  parameter_group_name = "default.postgres11"
  skip_final_snapshot  = true
  publicly_accessible  = false
  deletion_protection  = var.instance_deletion_protection

  # To enable storage autoscaling: max > allocated
  allocated_storage     = var.instance_db_allocated_storage     // 10
  max_allocated_storage = var.instance_db_max_allocated_storage // 20

  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds-sg.id]

}
