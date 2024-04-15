# Create kms policy document to reference when creating kms key
data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid     = "Enable IAM User Permissions"
    effect  = "Allow"
    actions = ["kms:*"]
    resources = ["*"]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
  }
}

# create key from key management system
resource "aws_kms_key" "ACS-kms" {
  description = "KMS key"
  policy = data.aws_iam_policy_document.kms_policy.json
  tags = merge(
    var.tags,
    {
      Name = "ACS-kms"
    },
  )

}

# create key alias
resource "aws_kms_alias" "alias" {
  name          = "alias/kms"
  target_key_id = aws_kms_key.ACS-kms.key_id
}

# create Elastic file system
resource "aws_efs_file_system" "ACS-efs" {
  encrypted  = true
  kms_key_id = aws_kms_key.ACS-kms.arn

tags = merge(
    var.tags,
    {
      Name = "ACS-file-system"
    },
  )
}


# set first mount target for the EFS 
resource "aws_efs_mount_target" "subnet-1" {
  file_system_id  = aws_efs_file_system.ACS-efs.id
  subnet_id       = var.efs-subnet-1
  security_groups = var.efs-sg
}


# set second mount target for the EFS 
resource "aws_efs_mount_target" "subnet-2" {
  file_system_id  = aws_efs_file_system.ACS-efs.id
  subnet_id       = var.efs-subnet-2
  security_groups = var.efs-sg
}


# create access point for fms
resource "aws_efs_access_point" "fms" {
  file_system_id = aws_efs_file_system.ACS-efs.id

  posix_user {
    gid = 0
    uid = 0
  }

  root_directory {
    path = "/www"

    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = 0755
    }

  }

  tags = merge(
    var.tags,
    {
      Name = "ACS-file-system"
    },
  )
}


