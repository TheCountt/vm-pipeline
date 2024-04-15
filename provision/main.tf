# module "vpc" {
#   source                              = "./modules/vpc"
#   region                              = var.region
#   vpc_cidr                            = var.vpc_cidr
#   enable_dns_support                  = var.enable_dns_support
#   enable_dns_hostnames                = var.enable_dns_hostnames
#   preferred_number_of_public_subnets  = var.preferred_number_of_public_subnets
#   preferred_number_of_private_subnets = var.preferred_number_of_private_subnets
#   private_subnets                     = [for i in range(1, 8, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
#   public_subnets                      = [for i in range(2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
#   environment                         = var.environment
# }

# module "security" {
#   source = "./modules/security"
#   vpc_id = module.vpc.vpc_id
# }

# # To get outputs from a module in Terraform 0.12 and above, you must export them from the root (e.g example_module) module using an output block in the caller module.

# output "vpc_outputs" {
#   value = module.vpc
# }

# output "security_outputs" {
#   value = module.security
# }

# resource "aws_instance" "bastion" {
#   ami                         = var.ami-bastion
#   instance_type               = var.instance_type
#   source_dest_check           = false
#   vpc_security_group_ids      = [module.security.bastion-sg]
#   subnet_id                   = module.vpc.public_subnets-1
#   associate_public_ip_address = true
#   key_name                    = var.ssh_key_name
#   user_data                   = var.user_data

#   tags = merge(
#     var.tags,
#     {
#       Name = "ACS-bastion"
#     },
#   )
# }

# module "bastion" {
#   source = "./modules/bastion"
#   ami                        = var.ami-bastion
#   bastion-sg = [module.security.bastion-sg]
#   public_subnets-1 = module.vpc.public_subnets-1
#   instance_type               = var.instance_type
#   key_name                    = var.ssh_key_name
#   user_data                   = var.user_data
# }



