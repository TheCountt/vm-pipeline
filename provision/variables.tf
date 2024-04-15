variable "region" {}

variable "ami-bastion" {
  type        = string
  description = "ami for bastion"
}


variable "sg-bastion" {
  description = "security group for nginx instances"
  type        = list(any)
  default     = []
}

variable "public_subnet-1" {
  type        = string
  description = "A Public subnet in one AZ"
  default     = null
}

variable "instance_type" {
  type        = string
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

variable "vpc_cidr" {
  type = string
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "preferred_number_of_public_subnets" {
  type = number
}

variable "preferred_number_of_private_subnets" {
  type = number
}

variable "private_subnets" {
  type        = list(any)
  description = "List of private subnets"
  default     = []
}

variable "public_subnets" {
  type        = list(any)
  description = "list of public subnets"
  default     = []

}


variable "name" {
  type    = string
  default = "ACS"

}
variable "environment" {}
