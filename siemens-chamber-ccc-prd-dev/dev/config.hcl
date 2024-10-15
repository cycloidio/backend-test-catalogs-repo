# The following parameters can be configured by the CLS team
locals {
  chamber_name                = "aaa"
  aws_region                  = "us-west-1"
  soldto                      = 11368                   # OpenAir ID
  team                        = "US014725"              # Cost Center
  custgw_pub_ip               = "14.103.38.17"          # Akrostar public ip address
  custgw_subnets              = ["10.15.80.0/24", "10.15.88.0/24"]       # Akrostar allowed subnets
  aws_cidr                    = "10.10.10.0/24"         # Private address space used by chamber in AWS
  vpn_enabled                 = true
}

# The following parameters will be configured by the MCSEDA team
inputs = {
  tg_version                  = "versions/1.05/code"
  chamber_name                = "${local.chamber_name}"
  aws_region                  = "${local.aws_region}"
  cidr                        = "${local.aws_cidr}"
  azs                         = ["${local.aws_region}a", "${local.aws_region}b"]
  public_subnets              = ["10.10.10.0/26", "10.10.10.64/26"]
  private_subnets             = ["10.10.10.128/26", "10.10.10.192/26"]
  intra_subnets               = []
  lisc_svr_ami                = "ami-0993c44b77113d6eb"      #rhel8-salt-license-svr-v1-02
  lisc_svr_instance_type      = "m5.large"
  lmgrdport                   = "1717"
  mgcldport                   = "4000"
  iac-terraform-version       = "1.0"
  license_server_enabled      = true
  environment                 = "default"

  vpn_simulation_disabled           = true
  vpn_simulation_enabled            = false
  vpn_simulation_cidr               = "10.200.0.0/16"
  vpn_simulation_public_subnets     = ["10.200.101.0/24"]
  vpn_simulation_private_subnets    = ["10.200.0.0/24"]
  vpn_simulation_ec2_ami            = "ami-0993c44b77113d6eb"
  vpn_simulation_ec2_instance_type  = "t3.small"

  // Refer README for Datadog API Key arns
  datadog_key_arn             = "arn:aws:secretsmanager:us-west-2:209915287315:secret:Datadog-API-key-D4BxOV"
  custgw = {
    link1 = {
      pub_ip   = local.custgw_pub_ip  # aaa Public ip address
      subnets  = local.custgw_subnets # aaa subnets
    }
  }
  # 
  # Feature flags - to enable/disable certain capabilities
  vpn_enabled                       = local.vpn_enabled
  datadog_private_location_disabled = false

  tags = {
    account-name              = "AWS-PROD-LIC"
    account-owner             = "sam.george@siemens.com"
    backup                    = "False"
    customer                  = "${local.chamber_name}"
    env                       = "prod"
    environment               = "prod"
    intent                    = "${local.chamber_name}"
    product                   = "license"
    SECURITY_CONTACT_EMAIL    = "mcseda-team.us@siemens.com"
    EMAIL                     = "mcseda-team.us@siemens.com"
    soldto                    = local.soldto
    segment                   = "license"
    service                   = "${local.chamber_name}-prod"
    sharedresource            = "No"
    start-time                = "00:00"
    stop-time                 = "00:00"
    team                      = local.team
    timezone                  = "EST"
    datadog                   = "true"
  }
}
