# #  Create S3 bucket to store external alb access logs for visitors
# resource "aws_s3_bucket" "alb_access_logs" {
#   bucket = "alb-logs-01x"
#   force_destroy = true
#   tags = merge(
#     var.tags,
#     {
#       Name = "ACS-alb_access_logs"
#     }
#   )
# }


# resource "aws_s3_bucket_acl" "log_bucket_acl" {
#   bucket = aws_s3_bucket.alb_access_logs.id
#   acl    = "log-delivery-write"
# }

# resource "aws_s3_bucket_logging" "alb_access_logging" {
#   bucket = aws_s3_bucket.alb_access_logs.id

#   target_bucket = aws_s3_bucket.alb_access_logs.id
#   target_prefix = "access-log/"
# }

