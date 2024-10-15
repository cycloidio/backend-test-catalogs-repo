include "root" {
  path = find_in_parent_folders()
}

locals {
  config = read_terragrunt_config("../config.hcl")
}

include "env" {
  path = "${get_repo_root()}/${read_terragrunt_config(find_in_parent_folders("config.hcl")).inputs.tg_version}/_env/custvpn.hcl"
}

skip = !local.config.inputs.vpn_enabled