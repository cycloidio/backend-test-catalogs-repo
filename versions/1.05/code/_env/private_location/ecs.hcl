#terraform {
#  source ="git::https://gitlab.com/cycloidio/siemens-iac-terraform.git//modules/ecs?ref=v1.51"
#}

dependency "vpc" {
  config_path = "../../vpc"
}

locals {
  config = read_terragrunt_config("../../config.hcl")
  instance_type = try(local.config.inputs.instance_type, "m5.large")
  gpu_enabled = try(local.config.inputs.gpu_enabled, false)
  gpu_instance_type = try(local.config.inputs.gpu_instance_type, "g4dn.xlarge")
  ecs_max_size = try(local.config.inputs.ecs_max_size, 1)
  ecs_min_size = try(local.config.inputs.ecs_min_size, 1)
  ecs_desired_capacity = try(local.config.inputs.ecs_desired_capacity, 1)
}

inputs = {
  tags = local.config.inputs.tags
  chamber_name = "dd-${local.config.inputs.chamber_name}"
  vpc_id = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnets
  azs = local.config.inputs.azs
  instance_type = local.instance_type
  minimum_size  = local.ecs_min_size
  maximum_size  = local.ecs_max_size
  desired_capacity = local.ecs_desired_capacity
  gpu_enabled = local.gpu_enabled
  gpu_instance_type = local.gpu_instance_type
  aws_region = local.config.inputs.aws_region
}
