output "private_ip" {
  value = aws_instance.web.private_ip
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "instance_type" {
  value = aws_instance.web.instance_type
}