terraform {
  source = "tfr:///terraform-aws-modules/vpn-gateway/aws//.?version=3.3.0"
}

locals {
  config = read_terragrunt_config("../config.hcl")
}

dependency "vpc" {
  config_path = "../vpc"
}


inputs = {
  tags                                      = merge( {Name = "${local.config.inputs.chamber_name}-vpn"},  local.config.inputs.tags)
  vpc_id                                    = dependency.vpc.outputs.vpc_id
  vpn_gateway_id                            = dependency.vpc.outputs.vgw_id
  create_vpn_gateway_attachment             = false
  customer_gateway_id                       = dependency.vpc.outputs.cgw_ids[0]
  vpc_subnet_route_table_count              = length(dependency.vpc.outputs.private_route_table_ids)
  vpc_subnet_route_table_ids                = dependency.vpc.outputs.private_route_table_ids
  vpn_connection_static_routes_only         = true
  vpn_connection_static_routes_destinations = local.config.inputs.custgw.link1.subnets
}
