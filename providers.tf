provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "hygear-terraformstate"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
