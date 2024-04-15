# create instance for app-servers
resource "aws_instance" "app-server" {
  ami                         = var.ami-app-server
  instance_type               = var.instance_type
  # subnet_id                 = "${var.private_subnet-1}"
  subnet_id                   = var.public_subnet-1
  vpc_security_group_ids      = var.sg-app-server
  # private_ip                  = var.nginx_private_ip
  source_dest_check           = false
  associate_public_ip_address = true
  key_name                    = var.ssh_key_name
  user_data                   = var.user_data
  root_block_device {

    volume_size = 15
    volume_type = "gp3"

  }


  tags = merge(
    var.tags,
    {
      Name = "ACS-app-server"
    },
  )
}