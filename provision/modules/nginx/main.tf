#create instance for nginx
resource "aws_instance" "nginx" {
  ami                         = var.ami-nginx
  instance_type               = var.instance_type
  subnet_id                   = "${var.public_subnet-1}"
  iam_instance_profile        = "aws_instance_profile_test"
  # private_ip                  = var.nginx_private_ip
  source_dest_check           = false
  vpc_security_group_ids      = var.sg-nginx
  associate_public_ip_address = true
  key_name                    = var.ssh_key_name
  user_data                   = var.user_data

   tags = merge(
    var.tags,
    {
      Name = "ACS-nginx"
    },
  )
}

