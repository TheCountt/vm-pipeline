# create DB subnet group from the private subnets
resource "aws_db_subnet_group" "ACS-rds" {
  name       = "acs-rds"
  subnet_ids = var.private_subnets

  tags = merge(
    var.tags,
    {
      Name = "ACS-dbsubnet-group"
    },
  )
}



# create the RDS instance with the subnets group
resource "aws_db_instance" "ACS-rds" {
  allocated_storage      = var.allocated_storage
  storage_type           = "gp3"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.instance_class
  identifier             = "fms"
  username               = local.db_secret.username
  password               = local.db_secret.password
  # blue_green_update      = var.blue_green_update
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  publicly_accessible    = var.publicly_accessible
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.ACS-rds.name

  # this should be changed to false for live dev & prod
  skip_final_snapshot    = var.skip_final_snapshot 
  final_snapshot_identifier = var.final_snapshot_identifier
  vpc_security_group_ids = [var.db-sg]
  multi_az               = "true"
  tags = merge(
    var.tags,
    {
      Name = "ACS-database"
    },
  )
}
