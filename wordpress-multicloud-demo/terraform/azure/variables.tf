# Cycloid
variable "customer" {}
variable "project" {}
variable "env" {}

# Azure
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_subscription_id" {}
variable "azure_tenant_id" {}

variable "azure_env" {
  default = "public"
}

variable "azure_resource_group_name" {}

variable "azure_location" {
  default = "francecentral"
}

# Stack
variable "git_code_commit" {
  default = "origin/code"
}
variable "git_code_repo" {
  default = "https://github.com/cycloid-community-catalog/docs-step-by-step-stack.git"
}
