# Cycloid
variable "customer" {
  default = "cycloid"
}
variable "project" {
  default = "snowy"
}
variable "env" {
  default = "demo"
}

# Azure
variable "resource_group_name" {}
variable "azure_location" {
  default = "francecentral"
}

# Stack
variable "subnet_id" {}

variable "instance_type" {
  default = "Standard_DS1_v2"
}

variable "git_code_commit" {}
variable "git_code_repo" {}
