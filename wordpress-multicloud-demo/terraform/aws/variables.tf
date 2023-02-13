# Cycloid
variable "customer" {}
variable "project" {}
variable "env" {}

# AWS
variable "access_key" {}
variable "secret_key" {}
variable "aws_region" {
  default = "eu-west-1"
}

# Stack
variable "git_code_commit" {
  default = "origin/code"
}

variable "git_code_repo" {
  default = "https://github.com/cycloid-community-catalog/docs-step-by-step-stack.git"
}
