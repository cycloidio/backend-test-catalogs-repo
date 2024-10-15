#terraform {
#  source = "git::https://gitlab.com/cycloidio/siemens-iac-terraform.git//modules/datadog?ref=${local.config.inputs.iac-terraform-version}"
#}

dependency "asg" {
  config_path = "../license_svr/asg"
  skip_outputs = !local.config.inputs.license_server_enabled
  mock_outputs = {
    lic_dns_name   =  ["some-mock-value"]
  }
}

dependency "vpc" {
  config_path = "../vpc"
}

locals {
  config = read_terragrunt_config("../config.hcl")
}

inputs = {
  chamber_name              = local.config.inputs.chamber_name
  vpc_id                    = dependency.vpc.outputs.vpc_id
  datadog_api_key_arn       = local.config.inputs.datadog_key_arn
  datadog_app_key_arn       = local.config.inputs.datadog_app_key_arn
  private_dns_name          = dependency.asg.outputs.lic_dns_name[0]
  client_instance_id        = []
  datadog_dashboard_json    = "${get_terragrunt_dir()}/../../../DatadogDashboard.json"
}