dependencies {
  paths = ["../vpc", "../security"]
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "./modules/alb"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "temporary-dummy-id"
    private_subnets-1 = "dummy"
    private_subnets-2 = "dummy"
    public_subnets-1 = "dummy"
    public_subnets-2 = "dummy"

  }
  skip_outputs = true
}

dependency "security" {
  config_path = "../security"

  mock_outputs = {
  alb-sg = "temporary-dummy-id"
   ialb-sg = "dummy"
  }
  skip_outputs = true
}

inputs = {
    public-sg = dependency.security.outputs.alb-sg
    ip_address_type = "ipv4"
    load_balancer_type = "application"
    nginx_target_group_name = "nginx-reverse-proxy"
    vpc_id = dependency.vpc.outputs.vpc_id
    private-sg = dependency.security.outputs.ialb-sg
    private_subnet_ids = [dependency.vpc.outputs.private_subnets-1, dependency.vpc.outputs.private_subnets-2]
    public_subnet_ids =  [dependency.vpc.outputs.public_subnets-1, dependency.vpc.outputs.public_subnets-2]

    web_apps = [
    {
      name = "sso"
      port = 80
      host = "sso.example.com"
    },
    {
      name = "fma"
      port = 80
      host = "fma.example.com"
    },
     {
      name = "prodrive"
      port = 80
      host = "prodrive.example.com"
    }
  ]

  tags = {
    Owner-Email     = "demo.io"
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
    }
}