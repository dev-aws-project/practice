output "vpc_id" {
  value = aws_vpc.kuber.id
}

output "subnet_kuber_1a_id" {
  value = aws_subnet.kuber_1a.id
}

output "subnet_kuber_1b_id" {
  value = aws_subnet.kuber_1b.id
}

output "vpc_rds_dev_id" {
  value = aws_vpc.rds_dev.id
}

output "subnet_rds_dev_1a_id" {
  value = aws_subnet.rds_dev_1a.id
}

output "security_group_rds_dev_1a_id" {
  value = aws_security_group.rds_dev_1a.id
}

output "subnet_rds_dev_1b_id" {
  value = aws_subnet.rds_dev_1b.id
}

output "security_group_rds_dev_1b_id" {
  value = aws_security_group.rds_dev_1b.id
}

