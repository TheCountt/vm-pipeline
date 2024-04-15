variable "ami-app-server" {
    type = string
    description = "ami for app-server"
}

variable "sg-app-server" {
    description = "security group for app-server instances"
    type = list
    default =[]
}

# variable "private_subnet-1" {
#   type        = string
#   description = "A Private subnet in one AZ"
#   default = null
# }

variable "public_subnet-1" {
  type        = string
  description = "A Private subnet in one AZ"
  # default = null
}

# variable "app-server_private_ip" {
#   type        = string
#   description = "A private ip of app-server instance"
#   default = null
# }

variable "instance_type" {
    type = string
    description = "type of instance"
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for SSH access to the EC2 instance."
  type        = string
}

variable "user_data" {
  description = "User data script to be executed when the EC2 instance starts."
  type        = string
}


variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}
