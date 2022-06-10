
resource "aws_ssm_parameter" "ssm_rds_user" {
  name  = "/${local.prefix}/${local.environment}/${local.prefix}-rds-user"
  type  = "String"
  value = aws_db_instance.hygear_rds.username
}

resource "aws_ssm_parameter" "ssm_rds_password" {
  name  = "/${local.prefix}/${local.environment}/${local.prefix}-rds-password"
  type  = "SecureString"
  value = aws_db_instance.hygear_rds.password
}

resource "aws_ssm_parameter" "ssm_rds_address" {
  name  = "/${local.prefix}/${local.environment}/${local.prefix}-rds-endpoint"
  type  = "String"
  value = aws_db_instance.hygear_rds.address
}
resource "aws_ssm_parameter" "db_name" {
  name  = "/${local.prefix}/${local.environment}/${local.prefix}-dbname"
  type  = "String"
  value = aws_db_instance.hygear_rds.name
}