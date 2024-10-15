include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path = "${get_repo_root()}/${read_terragrunt_config(find_in_parent_folders("config.hcl")).inputs.tg_version}/_env/license_svr_asg/sg_license.hcl"
}
