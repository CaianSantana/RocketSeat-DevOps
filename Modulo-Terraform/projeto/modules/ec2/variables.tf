variable "ec2_ami" {
  description = "Imagem base para instância EC2"
  type = string
  default = ""
}

variable "ec2_instance_type" {
  description = "Tipo padrão para instância EC2"
  type = string
  default = ""
}

variable "ec2_tags" {
  description = "Tags para instância EC2"
  type = map(string)
  default = {}
}

variable "ec2_subnet_id" {
  description = "Id da subrede para instância EC2"
  type = string
  default = ""
}

variable "ec2_security_groups" {
  description = "Lista de Grupos de Segurança para instância EC2"
  type = list(string)
  default = []
}