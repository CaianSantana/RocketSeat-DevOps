variable "vpc_cidr_range" {
  description = "Subrede"
  type = string
  default = "10.10.1.0/24"
}

variable "vpc_tenancy" {
  description = "Locatário da rede"
  type = string
  default = "default"
}

variable "vpc_tags" {
  description = "Tags da VPC"
  type = map(string)
  default = {}
}