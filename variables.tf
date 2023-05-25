variable "acc_number" {
  description = "AWS Account Number"
  type        = string
  default     = "xxxxxxxxxxx"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "availability_zones" {
  description = "AWS availability zones"
  type        = list
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "env" {
  description = "xxxxxxxxx Environment"
  type        = string
}

variable "zendesk_hostname" {
  description = "Zendesk Hostname"
  type        = string
  default     = "xxxxxxxxxxxxx.zendesk.com"
}

variable "zendesk_username" {
  description = "Zendesk Username"
  type        = string
  default     = "no-reply+zendesk@xxxxxxxx.net"
}

variable "zendesk_token" {
  description = "Zendesk Token"
  type        = string
}

variable "db_database_name" {
  description = "Database Name"
  type        = string
  default     = "ztm"
}

variable "db_username" {
  description = "Database Username"
  type        = string
  default     = "ztm"
}

variable "container_image" {
  description = "ZTM Container Image"
  type        = string
  default     = "xxxxxxxxxxxxxx.dkr.ecr.eu-central-1.amazonaws.com/prod-analytics-integrations/zendesk-ticket-mapper:0.5"
}

variable "task_subnets" {
  type     = list
  default  = ["subnet-xxxxxxxxxx", "subnet-xxxxxx", "subnet-0xxxxxxxx"]
}

variable "db_subnets" {
  type     = list
  default  = ["subnet-xxxxxxxxxx", "subnet-xxxxxxxxxxx", "subnet-xxxxxxxxx"]
}

variable "ecs_cluster_arn" {
  type    = string
  default = "arn:aws:ecs:eu-central-1:xxxxxxxxx:cluster/prod-ztm"
}

resource "random_password" "db_password" {
  length           = 16
  special          = false
}
