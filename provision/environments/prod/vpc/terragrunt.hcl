include {
  path = find_in_parent_folders()
}

terraform {
  source = "./modules/vpc"
}

inputs = {
  
region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

private_subnets = [for i in range(1, 8, 2) : cidrsubnet("10.0.0.0/16", 8, i)]

public_subnets = [for i in range(2, 5, 2) : cidrsubnet("10.0.0.0/16", 8, i)]

environment = "staging"

tags = {
  Owner-Email     = "demo.io",
  Managed-By      = "Terraform",
  Billing-Account = "1234567890"
      }
}