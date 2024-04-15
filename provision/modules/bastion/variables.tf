variable "ami-bastion" {
    type = string
    description = "ami for nginx"
}


variable "sg-bastion" {
    description = "security group for nginx instances"
    type = list
    default = []
}

variable "public_subnet-1" {
  type        = string
  description = "A Public subnet in one AZ"
  default = null
}

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
