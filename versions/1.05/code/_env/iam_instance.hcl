terraform {
  source = "git::https://gitlab.com/cycloidio/siemens-iac-terraform.git//modules/iam_instance_profile?ref=v1.51"
}

locals {
  config = read_terragrunt_config("../config.hcl")
}

inputs = {
  role_name         = "compute_instance_profile_${local.config.inputs.chamber_name}"
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  }
  description           = "compute_instance_profile_${local.config.inputs.chamber_name}"
  service               = "ec2.amazonaws.com"
  tags                  = local.config.inputs.tags # Assuming you have tags defined in your config
  managed_policy_arns   = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
  ]
}
