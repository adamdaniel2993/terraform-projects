# data "aws_route53_zone" "zone" {
#   provider = aws.dnsinfra
#   name         = "devops.sweatworks.net"
#   private_zone = false
# }

# resource "aws_route53_record" "hygear_cms" {
#   provider = aws.dnsinfra
#   zone_id  = data.aws_route53_zone.zone.zone_id
#   name     = "staging.hygear-cms"
#   type     = "CNAME"
#   ttl      = "300"
#   records  = ["${aws_alb.frontend_load_balancer.dns_name}."]
# }


# resource "dns_cname_record" "hygear_cms" {
#   zone  = "devops.sweatworks.net."
#   name  = "staging.hygear-cms"
#   cname = "${aws_alb.frontend_load_balancer.dns_name}."
#   ttl   = 300
# }
/*
resource "aws_acm_certificate" "frontend" {
  domain_name       = "staging.hygear-cms.devops.sweatworks.net"
  validation_method = "DNS"

  tags = {
    Environment = "hygear"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_acm_certificate" "api" {
  domain_name       = "staging.hygear-api.devops.sweatworks.net"
  validation_method = "DNS"

  tags = {
    Environment = "hygear"
  }

  lifecycle {
    create_before_destroy = true
  }
}
*/