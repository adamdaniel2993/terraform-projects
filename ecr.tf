
################# hygear-API-Repo ##########################
resource "aws_ecr_repository" "hygear-api" {
  name                 = "${local.prefix}-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


################## hygear-Frontend-Repo #########################
resource "aws_ecr_repository" "hygear-frontend" {
  name                 = "${local.prefix}-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
