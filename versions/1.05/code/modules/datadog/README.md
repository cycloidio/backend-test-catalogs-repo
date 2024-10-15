# Kubernetes Datadog module

## Usage
```hcl
module "datadog_dashboard" {
  source = "./modules/datadog"
  chamber_name              = local.config.inputs.chamber_name
  vpc_id                    = dependency.vpc.outputs.vpc_id
  datadog_api_key_arn       = local.config.inputs.datadog_key_arn
  datadog_app_key_arn       = local.config.inputs.datadog_app_key_arn
  private_dns_name          = dependency.asg.outputs.lic_dns_name  
}
```

## Examples

## Requirements
| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers
| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.0 |

## Modules
No modules.

## Resources

## Inputs
| Name           | Description                                      | Type  | Default | Required |
|----------------|--------------------------------------------------|-------|---------|:--------:|
| chamber_name | Name of the chamber  | `string` | `""` |  yes  |
| vpc_id | VPC ID for chamber | `string` | `""` |  yes  |
| private_dns_name | License server DNS Name  | `string` | `""` |  yes  |
| datadog_api_key_arn | ARN for datadog API key secret  | `string` | `""` |  yes  |
| datadog_app_key_arn | ARN for datadog APP key secret  | `string` | `""` |  yes  |

## Outputs



