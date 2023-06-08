output "vpc_id" {
  value = aws_vpc.kuber.id
}

output "subnet_kuber_1a_id" {
  value = aws_subnet.kuber_1a.id
}

output "subnet_kuber_1b_id" {
  value = aws_subnet.kuber_1b.id
}

