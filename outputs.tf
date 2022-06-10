output "vpc_id" {
  value = module.hygear-vpc.vpc_id
}
output "private_subnet_ids" {
  value = module.hygear-vpc.private_subnets
}
output "pulbic_subnet_ids" {
  value = module.hygear-vpc.public_subnets
}

output "rds_endpoint" {
  value       = aws_db_instance.hygear_rds.endpoint
  description = "RDS Database endpoint"
}
