output "efs_id" {
  value = aws_efs_file_system.ACS-efs.id
}

output "efs_dns_name" {
  value = aws_efs_file_system.ACS-efs.dns_name
}

output "mount_target_1" {
  value = aws_efs_mount_target.subnet-1.id
}

output "mount_target_2" {
  value = aws_efs_mount_target.subnet-2.id
}

output "access_point_id" {
  value = aws_efs_access_point.fms.id
}
