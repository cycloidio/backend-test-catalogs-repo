# Cycloid
variable "customer" {}
variable "project" {}
variable "env" {}

# GCP
variable "gcp_project" {
  default = "cycloid-demo"
}
variable "gcp_zone" {
  default = "europe-west1-b"
}

# Stack
variable "git_code_commit" {
  default = "origin/code"
}
variable "git_code_repo" {
  default = "https://github.com/cycloid-community-catalog/docs-step-by-step-stack"
}
