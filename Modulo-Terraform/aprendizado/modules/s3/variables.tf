variable "org_name" {
  type    = string
  default = ""
  description = "Nome da Org"
}

variable "bucket_name" {
  type    = string
  default = ""
  description = "Nome do Bucket"
}

variable "s3_tags"{
  type    = map(string)
  default = {}
  description = "Tags de criação"
}