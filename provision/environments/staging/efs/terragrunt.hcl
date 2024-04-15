// depends on vpc and the security group in vpc and security 
// module folders respectively of staging env
dependencies {
  paths = ["../vpc", "../security"]
}


include {
  path = find_in_parent_folders()
}

terraform {
  source = "./modules/efs"
}


dependency "security" {
  config_path = "../security"

  mock_outputs = {
    datalayer-sg = "temporary-dummy-id"
  }
  // skip_outputs = true
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    private_subnets-1 = "temporary-dummy-id"
    private_subnets-2 = "temporary-dummy-id"
  }
  // skip_outputs = true
}

inputs = {
  "efs-subnet-1" = dependency.vpc.outputs.private_subnets-1
  "efs-subnet-2" = dependency.vpc.outputs.private_subnets-2
  "efs-sg"       = [dependency.security.outputs.datalayer-sg]

  tags = {
    Owner-Email     = "demo.io"
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }
}
