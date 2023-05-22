output "public_lb_dns" {
    value = aws_lb.loadbalancers[0].dns_name
}

output "private_lb_dns" {
    value = aws_lb.loadbalancers[1].dns_name
}