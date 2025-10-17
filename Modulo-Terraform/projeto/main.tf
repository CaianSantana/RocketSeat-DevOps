module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_range = "10.10.0.0/16"
  vpc_tenancy    = "default"

  vpc_tags = {
    IaC  = true
    Name = "main"
    Env  = terraform.workspace
  }

  vpc_subnet_tags = {
    IaC  = true
    Name = "main"
  }

  vpc_sg_tags = {
    IaC  = true
    Name = "main"
  }
}

module "ec2" {
  source = "./modules/ec2"
}