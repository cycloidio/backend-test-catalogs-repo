terraform {
  source = "git::https://gitlab.com/cycloidio/siemens-iac-terraform.git//modules/ec2_instances?ref=v1.51"
}

dependency "sg" {
  config_path = "../sg"
  skip_outputs = !local.config.inputs.vpn_simulation_enabled
  mock_outputs = {
    security_group_id   =  "some-mock-value"
  }
}

dependency "vpc" {
  config_path = "../../parallel_vpc"
  skip_outputs = !local.config.inputs.vpn_simulation_enabled
  mock_outputs = {
    vpc_id   =  "some-mock-value"
    private_subnets = ["some-mock-value"]
  }
}

dependency "iam" {
  config_path = "../../iam_instance"
  skip_outputs = !local.config.inputs.vpn_simulation_enabled
  mock_outputs = {
    profile_name   =  "some-mock-compute-profile"
  }
}

locals {
  config = read_terragrunt_config("../../config.hcl")
}

inputs = {
  tags                        = local.config.inputs.tags
  instances                   = [[
    {
      name                    = "${local.config.inputs.chamber_name}_vpn_simulation_instance"
      ami                     = local.config.inputs.vpn_simulation_ec2_ami
      instance_type           = local.config.inputs.vpn_simulation_ec2_instance_type
      disk_gb                 = null
      imdsv1_disabled         = false  # Set this to either true or false
      user_data               = templatefile("${get_terragrunt_dir()}/../scripts/startup_script.sh", {})
    }
  ]]
  security_group_ids          = [dependency.sg.outputs.security_group_id]
  subnet_id                   = dependency.vpc.outputs.private_subnets[0]
  iam_instance_profile        = dependency.iam.outputs.instance_profile_name
}

