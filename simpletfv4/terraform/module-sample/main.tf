# Here is an example of dummy terraform resource
# https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource

resource "null_resource" "example" {
  triggers = {
    name = "${var.organization}-${var.project}-${var.env}-${var.component}"
    type = var.tshirt_size
  }
}
