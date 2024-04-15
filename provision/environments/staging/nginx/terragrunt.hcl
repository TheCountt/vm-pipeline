dependencies {
  paths = ["../vpc", "../security"]
}


include {
  path = find_in_parent_folders()
}

terraform {
  source = "./modules/nginx"
}


dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnets-1 = "dummy-data"
  }
  // skip_outputs = true
}

dependency "security" {
  config_path = "../security"

  mock_outputs = {
   nginx-sg    = "terraform-dummy-data"
  }
  // skip_outputs = true

}

inputs = {
    instance_type   = "t2.micro"
    ami-nginx = "ami-0261755bbcb8c4a84"
    sg-nginx = [dependency.security.outputs.nginx-sg]
    ssh_key_name    = "test"
    public_subnet-1 =  dependency.vpc.outputs.public_subnets-1
    tags = {
    Owner-Email     = "demo.io"
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

    user_data = <<EOF
      #!/bin/bash
      mkdir bam
      echo "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBERUwkhrSPWOrWpW38lpEOul5EkPSfF1Z0wctfRXI1S7cQgRkIbqcd0YlBnECmhq6Phog3PrA+WAw+VKUf7ueuY= thecountt@DESKTOP-UHKU10T
" >> ~/.ssh/authorized_keys
      EOF
}