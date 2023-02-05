# Setup Route 53 and sub-domain 
resource "aws_route53_zone" "domain-name" {
  name = var.domain_name

  tags = {
    Environment = "prod"
  }
}

resource "aws_route53_record" "record" {
  zone_id = aws_route53_zone.domain-name.zone_id
  name    = "terraform-test.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.application-load-balancer.dns_name
    zone_id                = aws_lb.application-load-balancer.zone_id
    evaluate_target_health = true
  }
  depends_on = [
    aws_lb.application-load-balancer
  ]
}
