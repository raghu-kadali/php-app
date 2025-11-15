terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# ---------------------------------------------------------
# VPC + Subnet
# ---------------------------------------------------------
resource "google_compute_network" "vpc" {
  name = "php-vpc"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "php-subnet"
  region        = var.region
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.vpc.id
}

# ---------------------------------------------------------
# Firewall for HTTP (port 80)
# ---------------------------------------------------------
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["php-server"]
}

resource "google_compute_firewall" "allow_gcp_healthchecks" {
  name    = "allow-healthchecks"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]

  target_tags = ["php-server"]
}

# ---------------------------------------------------------
# Instance Template (COS + Docker)
# ---------------------------------------------------------
resource "google_compute_instance_template" "php_template" {
  name         = "php-instance-template"
  machine_type = "e2-medium"
  tags         = ["php-server"]

  disk {
    auto_delete  = true
    boot         = true
    source_image = "projects/cos-cloud/global/images/family/cos-stable"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
  }

  metadata = {
    "gce-container-declaration" = <<EOF
spec:
  containers:
  - name: php-app
    image: "${var.docker_image}"
    ports:
      - containerPort: 80
        hostPort: 80
  restartPolicy: Always
EOF
  }

  service_account {
    email  = "default"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

# ---------------------------------------------------------
# MIG
# ---------------------------------------------------------
resource "google_compute_region_instance_group_manager" "php_mig" {
  name               = "php-mig"
  region             = var.region
  base_instance_name = "php-instance"

  version {
    instance_template = google_compute_i_
