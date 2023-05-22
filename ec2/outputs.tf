output "public_instance_ids" {
    value = aws_instance.public_ec2[*].id
}

output "private_instance_ids" {
    value = aws_instance.private_ec2[*].id
}