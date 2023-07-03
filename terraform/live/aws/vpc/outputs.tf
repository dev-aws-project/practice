output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_kuber_1a_id" {
  value = module.vpc.subnet_kuber_1a_id
}

output "subnet_kuber_1b_id" {
  value = module.vpc.subnet_kuber_1b_id
}

output "vpc_rds_dev_id" {
  value = module.vpc.vpc_rds_dev_id
}

output "subnet_rds_dev_1a_id" {
  value = module.vpc.subnet_rds_dev_1a_id
}

output "security_group_rds_dev_1a_id" {
  value = module.vpc.security_group_rds_dev_1a_id
}

output "subnet_rds_dev_1b_id" {
  value = module.vpc.subnet_rds_dev_1b_id
}

output "security_group_rds_dev_1b_id" {
  value = module.vpc.security_group_rds_dev_1b_id
}

output "security_group_allow_tls_id" {
  value = module.vpc.security_group_allow_tls_id
}
