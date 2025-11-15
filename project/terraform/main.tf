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
  name          = "php-
