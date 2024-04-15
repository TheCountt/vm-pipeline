dependencies {
  paths = ["../vpc", "../security", "../efs", "../mysql" ]
}


include {
  path = find_in_parent_folders()
}

terraform {
  source = "./modules/app-server"
}


dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    private_subnets-1 = "temporary-dummy-id"
    public_subnets-1 = "temporary-dummy-id"
  }

  skip_outputs = false  # change to true if upstream dependencies are not provisioned 
}

dependency "security" {
  config_path = "../security"

  mock_outputs = {
   app-server-sg = "temporary-dummy-id"

  }

  skip_outputs = false  # change to true if upstream dependencies are not provisioned 
}

dependency "efs" {
  config_path = "../efs"

  skip_outputs = true
}

dependency "mysql" {
  config_path = "../mysql"

  skip_outputs = true
}

inputs = {
    instance_type   = "t3.large"
    ami-app-server = "ami-0261755bbcb8c4a84"
    sg-app-server = [dependency.security.outputs.app-server-sg]
    ssh_key_name    = "test"
    // private_subnet-1 = dependency.vpc.outputs.private_subnets-1
    public_subnet-1 = dependency.vpc.outputs.public_subnets-1
    tags = {
    Owner-Email     = "demo.io"
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

    user_data = <<EOF
      #!/bin/bash
      mkdir isaac
      EOF
}