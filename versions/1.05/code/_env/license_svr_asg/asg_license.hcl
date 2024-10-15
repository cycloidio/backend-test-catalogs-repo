terraform {
  source = "git::https://gitlab.com/cycloidio/siemens-iac-terraform.git//modules/license_svr_asg?ref=v1.51"
}

dependency "sg" {
  config_path = "../sg"
  skip_outputs = !local.config.inputs.license_server_enabled
  mock_outputs = {
    security_group_id   =  "some-mock-value"
  }
}

dependency "vpc" {
  config_path = "../../vpc"
}

dependency "iam" {
  config_path = "../../iam_instance"
  skip_outputs = !local.config.inputs.license_server_enabled
  mock_outputs = {
    profile_name   =  "some-mock-compute-profile"
  }
}

dependency "secret" {
  config_path = "../secret"
  skip_outputs = !local.config.inputs.license_server_enabled
  mock_outputs = {
    secret_arns   =  ["some-mock-secret-arn"]
  }
}

locals {
  config = read_terragrunt_config("../../config.hcl")
}

inputs = {
  tags                      = local.config.inputs.tags
  chamber_name              = local.config.inputs.chamber_name
  instance_type             = local.config.inputs.lisc_svr_instance_type
  image_id                  = local.config.inputs.lisc_svr_ami
  instance_profile          = dependency.iam.outputs.instance_profile_name
  datadog_key_arn           = local.config.inputs.datadog_key_arn
  lic_secret_name_prefix    = "license_${local.config.inputs.chamber_name}"
  lic_secret_arn            = dependency.secret.outputs.secret_arns
  security_groups           = [dependency.sg.outputs.security_group_id]
  subnet_id                 = dependency.vpc.outputs.private_subnets[0]
  azs                       = [local.config.inputs.azs[0]]
}
