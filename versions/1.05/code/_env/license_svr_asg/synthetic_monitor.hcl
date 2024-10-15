#terraform {
#  source = "git::https://gitlab.com/cycloidio/siemens-iac-terraform.git//modules/datadog_synthetics?ref=${local.config.inputs.iac-terraform-version}"
#}

dependency "asg" {
  config_path = "../asg"
  skip_outputs = !local.config.inputs.license_server_enabled
  mock_outputs = {
    lic_dns_name   =  ["some-mock-value"]
  }
}

dependency "private_location" {
  config_path = "../../private_location/datadog_private_location"
  skip_outputs = !local.config.inputs.datadog_private_location_enabled
  mock_outputs = {
    datadog_private_location_id   =  "some-mock-value"
  }
}

locals {
  config = read_terragrunt_config("../../config.hcl")
}

inputs = {
  tags                         = local.config.inputs.tags
  chamber_name                 = local.config.inputs.chamber_name
  license_svr_ip               = dependency.asg.outputs.lic_dns_name
  datadog_private_location_id  = dependency.private_location.outputs.datadog_private_location_id
  datadog_site                 = "datadoghq.com"
  datadog_api_secret           = local.config.inputs.datadog_key_arn
  datadog_app_secret           = local.config.inputs.datadog_app_key_arn
}