output "vpc_id" {
  value = data.aws_vpc.vpc.id
  sensitive = false
  description = "ID da VPC"
}

output "vpc_main_route_table_id" {
  value = data.aws_vpc.vpc.main_route_table_id
  sensitive = false
  description = "ID da tabela de roteamento principal da VPC"
}