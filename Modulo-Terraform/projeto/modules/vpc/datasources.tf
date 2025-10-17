data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["main"]
  }
}

data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = ["main"]
  }
}

data "aws_security_group" "sg" {
  id = aws_security_group.sg.id
}