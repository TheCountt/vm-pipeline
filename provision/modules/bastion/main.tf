resource "aws_instance" "bastion" {
  ami                         = var.ami-bastion
  instance_type               = var.instance_type
  source_dest_check           = false
  vpc_security_group_ids      = [module.security.bastion-sg]
  subnet_id                   = module.vpc.public_subnets-1
  associate_public_ip_address = true
  key_name                    = var.ssh_key_name
  user_data                   = var.user_data

   tags = merge(
    var.tags,
    {
      Name = "ACS-bastion"
    },
  )
}