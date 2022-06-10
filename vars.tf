######## Generic Variables ########

variable "region" {
  type        = string
  description = "environment region"
}

variable "app_name" {
  type        = string
  description = "Name of the app"
}

variable "env" {
  type        = string
  description = "environment"

}

variable "frontend_name" {
  type        = string
  description = "frontend app name"

}


variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(any)
  default = {
    "Terraform" = "terraform"
  }
}
####### VPC Variables #########

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for VPC"
}


variable "vpc_az1" {
  type        = string
  description = "Availabity zone 1 "

}

variable "vpc_az2" {
  type        = string
  description = "Availabilty zone 2"
}

variable "vpc_public_subnets" {
  type        = list(any)
  description = "The CIDR block for the public subnet"
}

variable "vpc_private_subnets" {
  type        = list(any)
  description = "The CIDR block for the private subnet"
}

############# RDS Variables ###################

variable "instance_db_class" {
  type        = string
  description = "RDS instance type"
}

variable "instance_deletion_protection" {
  type        = bool
  description = "RDS Deletion Protection"
}

variable "instance_db_allocated_storage" {
  type        = number
  description = "RDS Allocated GB"
}

variable "instance_db_max_allocated_storage" {
  type        = number
  description = "RDS Max allocated GB"
}

############# API Gateway Variables ###################

variable "invoke_url_protocol" {
  type        = string
  description = "Invoke protocol to ELB from API GW, http or https"
}

############# ECS Variables ###################

variable "ecs_image_tag" {
  type        = string
  description = "Tag of the docker image to deploy"
}