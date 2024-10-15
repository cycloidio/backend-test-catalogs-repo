#
# This file has been generated by Cycloid, please DO NOT modify.
# Any manual modifications done to this file, WILL be lost on the
# next project edition via the forms.
#
# Please note that comments in sample files will have been dropped
# due to some limitations upon files' generation.
#
inputs = {
  aws_region = "us-west-2"
  azs = [
    "us-west-1a",
    "us-west-1b"
  ]
  chamber_name = "siemens-chamber-ccc-prd-dev"
  cidr         = "10.10.10.0/24"
  custgw = {
    link1 = {
      pub_ip = "14.103.38.17"
      subnets = [
        "10.15.80.0/24",
        "10.15.88.0/24"
      ]
    }
  }
  datadog_key_arn                   = "arn:aws:secretsmanager:us-west-2:209915287315:secret:Datadog-API-key-D4BxOV"
  datadog_private_location_disabled = false
  environment                       = "default"
  iac-terraform-version             = "1.0"
  intra_subnets = [

  ]
  license_server_enabled = true
  lisc_svr_ami           = "ami-0993c44b77113d6eb"
  lisc_svr_instance_type = "m5.large"
  lmgrdport              = "1717"
  mgcldport              = "4000"
  private_subnets = [
    "10.10.10.128/26",
    "10.10.10.192/26"
  ]
  public_subnets = [
    "10.10.10.0/26",
    "10.10.10.64/26"
  ]
  tags = {
    EMAIL                  = "mcseda-team.us@siemens.com"
    SECURITY_CONTACT_EMAIL = "mcseda-team.us@siemens.com"
    account-name           = "AWS-PROD-LIC"
    account-owner          = "sam.george@siemens.com"
    backup                 = "False"
    customer               = "aaa"
    datadog                = "true"
    env                    = "prod"
    environment            = "prod"
    intent                 = "aaa"
    product                = "license"
    segment                = "license"
    service                = "aaa-prod"
    sharedresource         = "No"
    soldto                 = 11368
    start-time             = "00:00"
    stop-time              = "00:00"
    team                   = "US014725"
    timezone               = "EST"
  }
  tg_version                       = "versions/1.05/code"
  vpn_enabled                      = true
  vpn_simulation_cidr              = "10.200.0.0/16"
  vpn_simulation_disabled          = true
  vpn_simulation_ec2_ami           = "ami-0993c44b77113d6eb"
  vpn_simulation_ec2_instance_type = "t3.small"
  vpn_simulation_enabled           = false
  vpn_simulation_private_subnets = [
    "10.200.0.0/24"
  ]
  vpn_simulation_public_subnets = [
    "10.200.101.0/24"
  ]
}
locals {
  aws_cidr      = "10.10.10.0/24"
  aws_region    = "us-west-2"
  chamber_name  = "siemens-chamber-ccc-prd-dev"
  custgw_pub_ip = "14.103.38.17"
  custgw_subnets = [
    "10.15.80.0/24",
    "10.15.88.0/24"
  ]
  soldto      = 11368
  team        = "US014725"
  vpn_enabled = true
}
