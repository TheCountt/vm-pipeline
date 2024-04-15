
// depends on vpc in vpc folder od shared resurces folder
dependencies {
  paths = ["../vpc"]
}


include {
  path = find_in_parent_folders()
}


terraform {
  source = "./modules/security"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "temporary-dummy-id"
  }

  // skip_outputs = true
}

inputs = {
    vpc_id = dependency.vpc.outputs.vpc_id

    tags = {
       Owner-Email     = "demo.io",
       Managed-By      = "Terraform",
       Billing-Account = "1234567890"
    }
}