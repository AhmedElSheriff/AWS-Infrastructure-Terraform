output "public_instance_ips" {
  value = module.ec2.public_instance_ips
}

output "private_instance_ips" {
  value = module.ec2.private_instance_ips
}

output "public_lb_dns" {
  value = module.loadbalancer.public_lb_dns
}

output "private_lb_dns" {
  value = module.loadbalancer.private_lb_dns
}