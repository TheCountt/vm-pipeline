variable "db-sg" {
  description = "The DB security group"
  type = string
  default = ""
}

variable "private_subnets" {
  type        = list
  description = "Private subnets from DB subnets group"
}

variable "allocated_storage" {
  description = "diskspace of DB"
  type = number
  default = 20
}

variable "instance_class" {
  description = "class of instance"
  type = string
  default = ""
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

# variable "blue_green_update" {
#   description = "Enables low-downtime updates using RDS Blue/Green deployments."
#   type = map(string)
#   default = {}
# }

variable "enabled_cloudwatch_logs_exports" {
  description = "log types to enable for exporting to CloudWatch logs"
  type = list
  default = ["audit", "error", "general", "slowquery"]
}

variable "publicly_accessible" {
  description = "control if instance is publicly accessible"
  type = bool
  default = false
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type = bool
  default = false
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted"
  type = string
  default = "fms"
}