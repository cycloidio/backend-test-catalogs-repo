#terraform {
#  source = "git::https://gitlab.com/cycloidio/siemens-iac-terraform.git//modules/datadog_private_location?ref=${local.config.inputs.iac-terraform-version}"
#}

dependency "vpc" {
  config_path = "../../vpc"
}

dependency "ecs" {
  config_path = "../ecs"
  skip_outputs = !local.config.inputs.datadog_private_location_enabled
    mock_outputs = !local.config.inputs.datadog_private_location_enabled? {
       ecs_arn =  "arn:aws:ecs:us-west-2:000000000000:cluster/dummy-ecs-cluster"
   } : {}
}

locals {
  config = read_terragrunt_config("../../config.hcl")
}

inputs = {
  tags = local.config.inputs.tags
  chamber_name = local.config.inputs.chamber_name
  ecs_cluster_arn = dependency.ecs.outputs.ecs_arn
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_sg_id = dependency.vpc.outputs.default_vpc_default_security_group_id
  subnet_ids = dependency.vpc.outputs.private_subnets
  datadog_site = "datadoghq.com"
  datadog_api_secret = local.config.inputs.datadog_key_arn
  datadog_app_secret = local.config.inputs.datadog_app_key_arn
  containers = {
    "datadog": {
        "name": "datadog-private-location",
        "image": "public.ecr.aws/datadog/synthetics-private-location-worker:latest",
        "memory": 2048,
        "cpu": 1024,
        "memory_reservation": 2048,
        "compatibilities": [
          "EC2"
        ],
        "log_configuration": {
          "logDriver": "awslogs",
          "options": {}
        },
        "port_mappings": []
      }
   }
}
