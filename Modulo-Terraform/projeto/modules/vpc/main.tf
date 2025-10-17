resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_range
  instance_tenancy = var.vpc_tenancy

  tags = var.vpc_tags
}