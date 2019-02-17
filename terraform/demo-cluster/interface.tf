variable "name" {
  description = "Name of the cluster that will be created."
}

variable "google_project" {
  description = "Name of the project used on GCP."
  default = "play-sandbox"
}

variable "google_region" {
  description = "Region used for the cluster."
  default = "europe-west1"
}

variable "google_zone" {
  description = "Zone used for the cluster."
  default = "europe-west1-d"
}

variable "min_master_version" {
  description = "Minimum version used for the masters of the cluster."
  default = "1.9.7-gke.0"
}
