// Configure the Google Cloud provider
provider "google" {
  project     = "${var.google_project}"
  region      = "${var.google_region}"
  zone        = "${var.google_zone}"
}

resource "google_container_cluster" "cluster" {
  name = "${var.name}"
  zone = "${var.google_zone}"

  min_master_version = "${var.min_master_version}"
  enable_legacy_abac = false

  network    = "default"
  subnetwork = "default"

  # Consumes too much resource or doesn't work :(
  # network_policy {
  #   enabled = true
  # }

  # Ignore changes for node pools so that removing one doesn't
  # "force new resource" for the cluster
  lifecycle = {
    "ignore_changes" = ["node_pool"]
  }
  # Remove the default-pool that google creates so that we can control it
  # outside of the cluster resource
  remove_default_node_pool = true
  node_pool = {
    name = "default-pool"
  }
}

resource "google_container_node_pool" "default-pool" {
  name       = "default-pool"
  node_count = 3

  cluster = "${google_container_cluster.cluster.name}"

  depends_on = ["google_container_cluster.cluster"]

  management = {
    auto_repair  = true
    # auto_upgrade = true
  }

  node_config = {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
