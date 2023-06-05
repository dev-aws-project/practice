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
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

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
    for_each = ["22", "80", "443", "8080"]
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



resource "aws_internet_gateway" "gw_dev" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "gw_dev"
  }
}


resource "aws_eip" "nat_gw_dev_eip" {
  vpc = true
}


resource "aws_nat_gateway" "nat_gw_dev" {
  subnet_id     = aws_subnet.dev_front.id
  allocation_id = aws_eip.nat_gw_dev_eip.allocation_id

  tags = {
    Name = "gw_NAT_dev"
  }
  depends_on = [aws_eip.nat_gw_dev_eip]
}

resource "aws_route_table" "front" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_dev.id
  }

  tags = {
    Name = "frontend-route-table"
  }
}

resource "aws_route_table" "back" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_dev.id
  }

  tags = {
    Name = "backend-route-table"
  }
}

resource "aws_route_table_association" "front_dev" {
  subnet_id      = aws_subnet.dev_front.id
  route_table_id = aws_route_table.front.id
}

resource "aws_route_table_association" "back_dev" {
  subnet_id      = aws_subnet.dev_back.id
  route_table_id = aws_route_table.back.id
}

# vpc

# subnets

# internet gateway

# nat gateway

# route tables

# security groups

# load balancer

