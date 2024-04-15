output "external_alb_dns_name" {
  value       = aws_lb.ext-alb.dns_name
  description = "DNS name of external Load balancer"
}

output "nginx-tgt" {
  description = "External Load balancer target group"
  value       = aws_lb_target_group.nginx-tgt.arn
}


output "aexternal-alb-zone" {
  description = "the az zone of the external loadbalancer"
  value = aws_lb.ext-alb.zone_id
}


output "internal_alb_dns_name" {
  value       = aws_lb.ialb.dns_name
  description = "DNS name of internal Load balancer"
}


output "sso-tgt" {
   description = "Internal Load balancer target group"
  value = aws_lb_target_group.sso-tgt.arn
}


