data "template_file" "user_data" {
  template = file("${path.module}/userdata.sh.tpl")

  vars = {
    git_code_commit = var.git_code_commit
    git_code_repo   = var.git_code_repo
    env             = var.env
    project         = var.project
  }
}

resource "google_compute_firewall" "default" {
  name    = "${var.customer}-${var.project}-front-${var.env}-http"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["${var.customer}-${var.project}-front-${var.env}-http"]
}

resource "google_compute_instance" "main" {
  name         = "${var.customer}-${var.project}-front-${var.env}"
  machine_type = var.instance_type
  zone         = var.gcp_zone

  tags = ["${var.customer}-${var.project}-front-${var.env}-http"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    environment = var.env
    project     = var.project
  }

  metadata_startup_script = data.template_file.user_data.rendered
}
