data "aws_secretsmanager_secret_version" "credentials" {
  # Fill in the name you gave to your secret in AWS secret manager
  secret_id = "db-secret"
}

locals {
  db_secret = jsondecode(
    data.aws_secretsmanager_secret_version.credentials.secret_string
  )

tags = merge(
    var.tags,
    {
      Name = "ACS-dbcredentials"
    },
  )
}