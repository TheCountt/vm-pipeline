# The security froup for external loadbalancer
variable "public-sg" {
  description = "Security group for external load balancer"
}


variable "vpc_id" {
  type        = string
  description = "The vpc ID"
}


variable "private-sg" {
  description = "Security group for Internal Load Balance"
}

variable "private_subnet_ids" {
  type = list
  description = "Private subnets to deploy Internal ALB"
  default = []
}


variable "public_subnet_ids" {
  type = list
  description = "Public subnets to deploy Internal ALB"
  default = []
}

variable "ip_address_type" {
  type        = string
  description = "IP address for the ALB"

}

variable "load_balancer_type" {
  type        = string
  description = "the type of Load Balancer"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}


variable "nginx_target_group_name" {
    type = string
    description = "name of the nginx target group"
}

variable "web_apps" {
  description = "List of web applications to serve on the ALB."
  type = list(object({
    name  = string
    port  = number
    host  = string
  }))
}