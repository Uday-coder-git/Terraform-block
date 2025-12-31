output "public" {
    value = aws_instance.name.public_ip
  
}
output "private" {
    value = aws_instance.name.private_ip
  
}