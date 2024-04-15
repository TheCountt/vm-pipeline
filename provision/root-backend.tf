#creating bucket for s3 backend
########################
# resource "aws_s3_bucket" "shared_resources" {
#   bucket        = "shared-resource-bucket"
#   force_destroy = true
#   tags = {
#     Owner-Email     = "demo.io"
#     Managed-By      = "Terraform"
#     Billing-Account = "1234567890"
#   }

# }

# resource "aws_s3_bucket_versioning" "enabled" {
#   bucket = aws_s3_bucket.shared_resources.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
#   bucket = aws_s3_bucket.shared_resources.id
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# # Explicity block all public access to the S3 bucket
# resource "aws_s3_bucket_public_access_block" "public-access-block" {
#   bucket                  = aws_s3_bucket.shared_resources.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_dynamodb_table" "shared_resource_locks" {
#   name         = "shared-resource-locks"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# # AWS S3 backend
# terraform {
#   backend "s3" {
#     bucket         = "shared-resource-bucket"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "shared-resource-locks"
#     encrypt        = true
#   }
# }