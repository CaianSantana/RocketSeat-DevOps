output "ec2_ami_id" {
  description = "ID da imagem da instancia"
  sensitive = false
  value = aws_instance.instance.ami
}

output "ec2_id" {
  description = "ID da instancia"
  sensitive = false
  value = aws_instance.instance.id
}

output "ec2_name" {
  description = "Nome da instancia"
  sensitive = false
  value = aws_instance.instance.tags.Name
}