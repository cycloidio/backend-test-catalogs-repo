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

# GCP
variable "gcp_zone" {
  default = "europe-west1"
}
variable "gcp_project" {}

# Stack
variable "instance_type" {
  default = "n1-standard-1"
}

variable "git_code_commit" {}
variable "git_code_repo" {}
