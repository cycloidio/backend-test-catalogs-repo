locals {
  env_config = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  config = read_terragrunt_config("${get_parent_terragrunt_dir()}/config.hcl")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "terraform-state-${local.config.inputs.aws_region}-${local.env_config.inputs.environment}-cycloid"
    key            = "aaa/${local.config.inputs.aws_region}/${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.config.inputs.aws_region}"
    profile        = "${local.env_config.inputs.environment}"
    encrypt        = true
    dynamodb_table = "${local.env_config.inputs.environment}-lock-table"
  }
}

generate "versions" {
  path      = "versions_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        aws = {
          source = "hashicorp/aws"
          version = "4.66.1"
        }
      }
    }
EOF
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region                      = "${local.config.inputs.aws_region}"
  profile                     = "${local.env_config.inputs.environment}"
}
EOF
}
