locals {
  prefix      = "hygear-${terraform.workspace}"
  environment = terraform.workspace
}

module "hygear-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.5.0"

  name = "${local.prefix}-vpc"
  cidr = var.vpc_cidr_block

  azs             = [var.vpc_az1, var.vpc_az2]
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Terraform   = "true"
    Environment = local.environment
  }
}


