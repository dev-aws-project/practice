resource "aws_vpc" "dev" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dev"
  }
}


resource "aws_subnet" "dev_back" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "back"
  }
}

resource "aws_subnet" "dev_front" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "front"
  }
}


resource "aws_subnet" "dev_db" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "db"
  }
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls_dev"
  description = "Allow TLS inbound traffic in dev environment"
  vpc_id      = aws_vpc.dev.id

  dynamic "ingress" {
    for_each = ["80", "443", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      #   ipv6_cidr_blocks = [aws_vpc.dev.ipv6_cidr_block]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
# vpc

# subnets

# internet gateway

# route tables

# security groups

# load balancer

