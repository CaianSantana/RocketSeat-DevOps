variable "aws_profile" {
  description = "Perfil da conta da AWS"
  type        = string
  default     = ""
}

variable "region" {
  description = "Região"
  type        = string
  default     = "us-west-2"
}

variable "instance_replicas" {
  description = "Numero de replicas da instancia"
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "Tipo de instância"
  type        = string
  default     = "t3.micro"
}

variable "environment" {
  description = "Ambiente"
  type = string
  default = "dev"
}