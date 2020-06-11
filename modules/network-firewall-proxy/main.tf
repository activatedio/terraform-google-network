terraform {
  # This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
  required_version = ">= 0.12"
}

data "google_compute_subnetwork" "active_proxy_subnetwork" {
  self_link = var.active_proxy_subnetwork
}

data "google_compute_subnetwork" "backup_proxy_subnetwork" {
  self_link = var.backup_proxy_subnetwork
}

// Define tags as locals so they can be interpolated off of + exported
locals {
  private             = "private"
}

# ---------------------------------------------------------------------------------------------------------------------
# private - allow ingress from within the proxy networks
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_firewall" "private_allow_all_network_inbound" {
  name = "${var.name_prefix}-private-allow-ingress-proxy"

  project = var.project
  network = var.network

  target_tags = [local.private]
  direction   = "INGRESS"

  source_ranges = [
    data.google_compute_subnetwork.active_proxy_subnetwork.ip_cidr_range,
    data.google_compute_subnetwork.backup_proxy_subnetwork.ip_cidr_range,
  ]

  priority = "1000"

  allow {
    protocol = "all"
  }
}

