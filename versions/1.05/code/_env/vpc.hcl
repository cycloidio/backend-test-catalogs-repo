terraform {
  source = "git::https://gitlab.com/cycloidio/siemens-iac-terraform.git//modules/vpc?ref=v1.51"
}

locals {
  config = read_terragrunt_config("../config.hcl")
}

inputs = {
  tags = local.config.inputs.tags
  name = "${local.config.inputs.chamber_name}-VPC"
  cidr = local.config.inputs.cidr

  azs               = local.config.inputs.azs
  private_subnets   = local.config.inputs.private_subnets
  public_subnets    = local.config.inputs.public_subnets

  transit_gateway_enabled = false
  enable_vpn_gateway      = true
  customer_gateways  = {
    IP1 = {
        bgp_asn      = 65000
        ip_address   = local.config.inputs.custgw.link1.pub_ip
    }
  }

  enable_dhcp_options   = false
  enable_dns_hostnames  = true

  customer_gateway_tags      = merge( {Name = "${local.config.inputs.chamber_name}-customer-gateway"},  local.config.inputs.tags)
  private_subnet_tags        = merge( {Name = "${local.config.inputs.chamber_name}-priv"},  local.config.inputs.tags)
  public_subnet_tags         = merge( {Name = "${local.config.inputs.chamber_name}-pub"},  local.config.inputs.tags)
  intra_route_table_tags     = merge( {Name = "${local.config.inputs.chamber_name}-intrart"},  local.config.inputs.tags)
  private_route_table_tags   = merge( {Name = "${local.config.inputs.chamber_name}-privrt"},  local.config.inputs.tags)
  public_route_table_tags    = merge( {Name = "${local.config.inputs.chamber_name}-pubrt"},  local.config.inputs.tags)
  igw_tags                   = merge( {Name = "${local.config.inputs.chamber_name}-igw"},  local.config.inputs.tags)
}
