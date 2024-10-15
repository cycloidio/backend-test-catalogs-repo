terraform {
  source = "tfr:///terraform-aws-modules/security-group/aws//.?version=4.17.1"
}

locals {
  config = read_terragrunt_config("../../config.hcl")
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {
  tags           = local.config.inputs.tags
  vpc_id         = dependency.vpc.outputs.vpc_id
  name           = "sg_lic_${local.config.inputs.chamber_name}"
  ingress_with_cidr_blocks = [
    { from_port = "${local.config.inputs.lmgrdport}", to_port = "${local.config.inputs.lmgrdport}", protocol = "tcp", cidr_blocks = join(",", local.config.inputs.custgw.link1.subnets), description = "${local.config.inputs.chamber_name} License SG: FlexLM" },
    { from_port = "${local.config.inputs.mgcldport}", to_port = "${local.config.inputs.mgcldport}", protocol = "tcp", cidr_blocks = join(",", local.config.inputs.custgw.link1.subnets), description = "${local.config.inputs.chamber_name} License SG: MGCLD" },
    { from_port = "8080", to_port = "8080", protocol = "tcp", cidr_blocks = join(",", local.config.inputs.private_subnets), description = "${local.config.inputs.chamber_name} License Datadog monitor" }
  ]
  egress_with_cidr_blocks = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = "0.0.0.0/0", description = "${local.config.inputs.chamber_name} License SG: SSH" },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = "0.0.0.0/0", description = "${local.config.inputs.chamber_name} License SG: HTTP" },
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = "0.0.0.0/0", description = "${local.config.inputs.chamber_name} License SG: HTTPS" },
    { from_port = 53, to_port = 53, protocol = "udp", cidr_blocks = "0.0.0.0/0", description = "${local.config.inputs.chamber_name} License SG: DNS" }
  ]
}
