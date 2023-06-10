resource "aws_vpc" "kuber" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "kuber"
  }
}


resource "aws_subnet" "kuber_1a" {
  vpc_id                  = aws_vpc.kuber.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "kuber"
  }
}

resource "aws_subnet" "kuber_1b" {
  vpc_id                  = aws_vpc.kuber.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "kuber"
  }
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls_kuber"
  description = "Allow TLS inbound traffic in kuber"
  vpc_id      = aws_vpc.kuber.id

  dynamic "ingress" {
    for_each = ["22", "80", "443", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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
    Name = "allow_tls_kuber"
  }
}



resource "aws_internet_gateway" "gw_kuber" {
  vpc_id = aws_vpc.kuber.id

  tags = {
    Name = "gw_kuber"
  }
}


resource "aws_eip" "nat_gw_kuber_eip" {
  vpc = true
}


resource "aws_nat_gateway" "nat_gw_kuber" {
  subnet_id     = aws_subnet.kuber_1a.id
  allocation_id = aws_eip.nat_gw_kuber_eip.allocation_id

  tags = {
    Name = "gw_NAT_kuber"
  }
  depends_on = [aws_eip.nat_gw_kuber_eip]
}

resource "aws_route_table" "kuber_1a" {
  vpc_id = aws_vpc.kuber.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_kuber.id
  }

  tags = {
    Name = "kuber_1a-route-table"
  }
}

resource "aws_route_table" "kuber_1b" {
  vpc_id = aws_vpc.kuber.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_kuber.id
  }

  tags = {
    Name = "kuber_1b-route-table"
  }
}

resource "aws_route_table_association" "kuber_1a" {
  subnet_id      = aws_subnet.kuber_1a.id
  route_table_id = aws_route_table.kuber_1a.id
}

resource "aws_route_table_association" "kuber_1b" {
  subnet_id      = aws_subnet.kuber_1b.id
  route_table_id = aws_route_table.kuber_1b.id
}


resource "aws_vpc" "rds_dev" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "rds_dev"
  }
}

resource "aws_subnet" "rds_dev_1a" {
  vpc_id                  = aws_vpc.rds_dev.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "rds_dev_1a"
  }
}


resource "aws_security_group" "rds_dev_1a" {
  name   = "rds_dev_1a"
  vpc_id = aws_vpc.rds_dev.id

  dynamic "ingress" {
    for_each = ["22", "80", "443", "8080", "5432"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

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
    Name = "rds_dev_1a"
  }
}



resource "aws_internet_gateway" "gw_rds_dev_1a" {
  vpc_id = aws_vpc.rds_dev.id

  tags = {
    Name = "gw_rds_dev_1a"
  }
}


resource "aws_eip" "nat_gw_rds_dev_1a_eip" {
  vpc = true
}


resource "aws_nat_gateway" "nat_gw_rds_dev_1a" {
  subnet_id     = aws_subnet.rds_dev_1a.id
  allocation_id = aws_eip.nat_gw_rds_dev_1a_eip.allocation_id

  tags = {
    Name = "gw_NAT_rds_dev_1a"
  }
  depends_on = [aws_eip.nat_gw_rds_dev_1a_eip]
}

resource "aws_route_table" "rds_dev_1a" {
  vpc_id = aws_vpc.rds_dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_rds_dev_1a.id
  }

  tags = {
    Name = "rds_dev_1a-route-table"
  }
}


resource "aws_route_table_association" "rds_dev_1a" {
  subnet_id      = aws_subnet.rds_dev_1a.id
  route_table_id = aws_route_table.rds_dev_1a.id
}



resource "aws_subnet" "rds_dev_1b" {
  vpc_id                  = aws_vpc.rds_dev.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "rds_dev_1b"
  }
}


resource "aws_security_group" "rds_dev_1b" {
  name   = "rds_dev_1b"
  vpc_id = aws_vpc.rds_dev.id

  dynamic "ingress" {
    for_each = ["22", "80", "443", "8080", "5432"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

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
    Name = "rds_dev_1b"
  }
}

resource "aws_eip" "nat_gw_rds_dev_1b_eip" {
  vpc = true
}


resource "aws_nat_gateway" "nat_gw_rds_dev_1b" {
  subnet_id     = aws_subnet.rds_dev_1b.id
  allocation_id = aws_eip.nat_gw_rds_dev_1b_eip.allocation_id

  tags = {
    Name = "gw_NAT_rds_dev_1b"
  }
  depends_on = [aws_eip.nat_gw_rds_dev_1b_eip]
}

resource "aws_route_table" "rds_dev_1b" {
  vpc_id = aws_vpc.rds_dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_rds_dev_1a.id
  }

  tags = {
    Name = "rds_dev_1b-route-table"
  }
}


resource "aws_route_table_association" "rds_dev_1b" {
  subnet_id      = aws_subnet.rds_dev_1b.id
  route_table_id = aws_route_table.rds_dev_1b.id
}


