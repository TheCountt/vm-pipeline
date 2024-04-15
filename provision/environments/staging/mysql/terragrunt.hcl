// depends on vpc in vpc folder of staging env
dependencies {
  paths = ["../vpc","../security"]
}


include {
  path = find_in_parent_folders()
}

terraform {
  source = "./modules/mysql"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    private_subnets-3 = "temporary-dummy-id"
    private_subnets-4 = "temp-dummy-id"
  }
  // skip_outputs = true
}

dependency "security" {
  config_path = "../security"
  mock_outputs = {
    datalayer-sg = "dummy"
  }
  // skip_outputs = true

}


inputs = {
    db-sg = dependency.security.outputs.datalayer-sg
    private_subnets = [dependency.vpc.outputs.private_subnets-3, dependency.vpc.outputs.private_subnets-4]
    // blue_green_update = {}
    allocated_storage = 30
    instance_class    = "db.t2.medium"
    enabled_cloudwatch_logs_exports = ["error"]
    publicly_accessible = true
    skip_final_snapshot = true
    finalsnapshot_identifier = "fms"
    tags = {
    Owner-Email     = "demo.io",
    Managed-By      = "Terraform",
    Billing-Account = "1234567890"
    }

}

