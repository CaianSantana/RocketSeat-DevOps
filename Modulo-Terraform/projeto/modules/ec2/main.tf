resource "aws_instance" "instance" {
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  subnet_id     = var.ec2_subnet_id
  vpc_security_group_ids = var.ec2_security_groups
  
  tags = var.ec2_tags
}