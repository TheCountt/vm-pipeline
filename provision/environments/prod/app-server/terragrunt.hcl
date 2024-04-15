dependencies {
  paths = ["../vpc", "../security", "../efs", "../mysql"]
}


include {
  path = find_in_parent_folders()
}

terraform {
  source = "./modules/webserver"
}


dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    private_subnets-1 = "dummy"
  }

  skip_outputs = true
}

dependency "security" {
  config_path = "../security"

  mock_outputs = {
   webserver-sg = "temporary-dummy-id"

  }

  skip_outputs = true
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
    instance_type   = "t2.micro"
    ami-webserver = "ami-0261755bbcb8c4a84"
    sg-webserver = [dependency.security.outputs.webserver-sg]
    ssh_key_name    = "test"
    private_subnet-1 = dependency.vpc.outputs.private_subnets-1
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