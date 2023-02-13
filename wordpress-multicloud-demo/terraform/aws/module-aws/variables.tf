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

# AWS
data "aws_region" "current" {}

# Stack
variable "keypair_name" {
  default = "demo"
}

variable "instance_type" {
  default = "t3.small"
}

variable "git_code_commit" {}
variable "git_code_repo" {}
