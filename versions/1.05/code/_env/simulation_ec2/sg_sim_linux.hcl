terraform {
  source = "tfr:///terraform-aws-modules/security-group/aws//.?version=4.17.1"

}

locals {
  config = read_terragrunt_config("../../config.hcl")
}

dependency "vpc" {
  config_path = "../../parallel_vpc"
  skip_outputs = !local.config.inputs.vpn_simulation_enabled
  mock_outputs = {
    vpc_id   =  "some-mock-value"
  }
}

inputs = {
  tags           = local.config.inputs.tags
  vpc_id         = dependency.vpc.outputs.vpc_id
  name           = "sg_sim_${local.config.inputs.chamber_name}"
  egress_with_cidr_blocks = [
    { from_port = -1, to_port = -1, protocol = -1, cidr_blocks = "0.0.0.0/0", description = "${local.config.inputs.chamber_name} Allow all trafic to Main VPC" }
  ]
}
