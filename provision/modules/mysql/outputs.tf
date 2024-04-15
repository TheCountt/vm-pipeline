output "rds_endpoint" {
  value = aws_db_instance.ACS-rds.endpoint
}

output "db_instance_address" {
  value = aws_db_instance.ACS-rds.address
}

output "db_instance_availability_zone" {
  value = aws_db_instance.ACS-rds.availability_zone
}

output "db_instance_username" {
  value = aws_db_instance.ACS-rds.username
  sensitive = true
}