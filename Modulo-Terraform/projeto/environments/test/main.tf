module "vpc" {
  source         = "../../modules/vpc"
  vpc_cidr_range = "10.10.0.0/16"
  vpc_tenancy    = "default"

  vpc_tags = {
    IaC         = true
    Name        = "main"
    Owner       = var.aws_profile
    Environment = terraform.workspace
  }

  vpc_subnet_tags = {
    IaC         = true
    Name        = "main"
    Owner       = var.aws_profile
    Environment = terraform.workspace
  }

  vpc_sg_tags = {
    IaC         = true
    Name        = "main"
    Owner       = var.aws_profile
    Environment = terraform.workspace
  }
}

module "ec2" {
  count = var.instance_replicas

  source              = "../../modules/ec2"
  ec2_ami             = data.aws_ami.debian_latest.id
  ec2_instance_type   = var.instance_type
  ec2_subnet_id       = module.vpc.vpc_subnet_id
  ec2_security_groups = [module.vpc.vpc_sg_id]

  ec2_tags = {
    IaC         = true
    Name        = "${terraform.workspace}-${data.aws_ami.debian_latest.id}-instance-${count.index + 1}"
    Owner       = var.aws_profile
    Environment = terraform.workspace
  }

  depends_on = [module.vpc]
}

module "elb_http" {
  source = "terraform-aws-modules/elb/aws"

  name = "elb-exemplo"

  subnets         = [module.vpc.vpc_subnet_id]
  security_groups = [module.vpc.vpc_sg_id]
  internal        = true

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 8080
      instance_protocol = "http"
      lb_port           = 8080
      lb_protocol       = "http"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  number_of_instances = var.instance_replicas
  instances           = [for instance in module.ec2 : instance.ec2_id]

  tags = {
    Owner       = var.aws_profile
    Environment = terraform.workspace
  }
}