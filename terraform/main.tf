# // Configure the Google Cloud provider
# provider "google" {
#   project     = "${var.google_project}"
#   region      = "${var.google_region}"
#   zone        = "${var.google_zone}"
# }

module "demo-XXXX" {
  source = "./demo-cluster"
  name = "demo-XXXX"
}
