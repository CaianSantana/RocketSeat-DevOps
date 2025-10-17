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
  count = 3

  source              = "./modules/ec2"
  ec2_ami             = data.aws_ami.debian_latest.id
  ec2_instance_type   = "t3.micro"
  ec2_subnet_id       = module.vpc.vpc_subnet_id
  ec2_security_groups = [module.vpc.vpc_sg_id]

  ec2_tags = {
    IaC  = true
    Name = "${terraform.workspace}-${data.aws_ami.debian_latest.id}-instance-${count.index + 1}"
  }

  depends_on = [module.vpc]
}