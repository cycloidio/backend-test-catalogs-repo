terraform {
  source = "tfr:///lgallard/secrets-manager/aws//.?version=0.6.2"
}

locals {
  licstub = <<EOF
SERVER ip-0-0-0-0.us-west-2.compute.internal coffee000000 1717
DAEMON saltd /opt/Siemens/LicenseServer PORT=4000
INCREMENT mentorall_s saltd 2023.020 24-feb-2023 1 SN=185064708 SIGN="0AD9 \
    NOTV ALID CDD1 AA84 9078 D27F EF8A E8E5 DA2C 6E8E 88E1 0F27 72E3 0A9C \
    1141 2293 EC28 A900 949D 60A8 5B78 FC5E 45FB 6AE4 DF90 7B73 72BF 1EDD \
    9222"
INCREMENT mentorall_s mgcld 2023.020 24-feb-2023 1 4F0653365C218545E2AC \
    VENDOR_STRING=FEAB6C18 SN=185064709 SIGN2="1C55 0A92 044D 97B5 6EB7 \
    NOTV ALID 780B C6C2 59DD BF5A D5D5 05D4 3C73 246D 122D 60C3 6D2D 01C7 \
    C461 B4B1 C415 FC8A A826 2DDF 52AC 7880 900C A8D2 FD0B"
EOF
  config   = read_terragrunt_config("../../config.hcl")
  secrets  = {
    "license_${local.config.inputs.chamber_name}_1" = {
      description              = "License file for ${local.config.inputs.chamber_name}"
      recovery_window_in_days  = 0
      secret_binary            = local.licstub
      tags                     = local.config.inputs.tags
    }
  }
}

inputs = {
  secrets = local.secrets
}