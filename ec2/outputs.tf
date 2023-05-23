output "public_instance_ids" {
    value = aws_instance.public_ec2[*].id
}

output "private_instance_ids" {
    value = aws_instance.private_ec2[*].id
}

output "public_instance_ips" {
  value = aws_instance.public_ec2[*].public_ip
}

output "private_instance_ips" {
  value = aws_instance.private_ec2[*].private_ip
}