terraform {
  source = "git::https://gitlab.com/cycloidio/siemens-iac-terraform.git//modules/vpc?ref=v1.51"
   

}

locals {
  config = read_terragrunt_config("../config.hcl")
}

inputs = {
  tags = local.config.inputs.tags
  name = "${local.config.inputs.chamber_name}-PARALLEL-VPC"
  cidr = local.config.inputs.vpn_simulation_cidr

  azs               = local.config.inputs.azs
  private_subnets   = local.config.inputs.vpn_simulation_private_subnets
  public_subnets    = local.config.inputs.vpn_simulation_public_subnets

  enable_dhcp_options   = false
  enable_dns_hostnames  = true

  customer_gateway_tags      = {Name = "customer_gateway_${local.config.inputs.chamber_name}"}
  intra_subnet_tags          = {Name = "intra-${local.config.inputs.chamber_name}"}
  private_subnet_tags        = {Name = "priv-${local.config.inputs.chamber_name}"}
  public_subnet_tags         = {Name = "pub-${local.config.inputs.chamber_name}"}
  intra_route_table_tags     = {Name = "intrart-${local.config.inputs.chamber_name}"}
  private_route_table_tags   = {Name = "privrt-${local.config.inputs.chamber_name}"}
  public_route_table_tags    = {Name = "pubrt-${local.config.inputs.chamber_name}"}
  igw_tags                   = {Name = "igw-${local.config.inputs.chamber_name}"}
}
