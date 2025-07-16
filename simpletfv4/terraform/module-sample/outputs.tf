# Example on how to use Terraform outputs https://developer.hashicorp.com/terraform/language/values/outputs
output "tshirt_id" {
  value = try(null_resource.example.id, "")
}
