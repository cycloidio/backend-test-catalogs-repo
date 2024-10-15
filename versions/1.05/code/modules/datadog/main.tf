data "aws_instance" "license_server" {
  filter {
    name   = "private-dns-name"
    values = ["${var.private_dns_name}"]
  }
  filter {
    name   = "vpc-id"
    values = ["${var.vpc_id}"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.chamber_name}_lisc_svr_asg"]
  }
}

resource "datadog_dashboard_json" "license_dashboard" {
  dashboard = templatefile("./LicenseServerOverview.json", {
    instance_id  = data.aws_instance.license_server.id
    chamber_name = var.chamber_name
  })
}