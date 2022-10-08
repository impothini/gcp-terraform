terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }

}

resource "google_compute_network" "vpc_network" {

  name = var.vpc_network_name

}


resource "google_compute_firewall" "ssh-default" {
  name    = "ssh-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}


module "kafka_cluster" {

  source = "./modules/kafka_cluster"

  broker_vm_attached_disk_size = 20
  broker_vm_attached_disk_type = "pd-ssd"
  broker_vm_count              = 1
  broker_vm_machine_type       = "f1-micro"
  ccc_vm_attached_disk_size    = 20
  ccc_vm_attached_disk_type    = "pd-ssd"
  ccc_vm_count                 = 1
  ccc_vm_machine_type          = "f1-micro"
  gcp_project                  = "lyrical-marker-362301"
  gcp_region                   = "us-central1"
  gcp_zone                     = "us-central1-c"
  vm_image_name                = "centos-7-v20220822"
  vm_labels = {
    application : "kafka"
  }
  vm_name_prefix                  = "kafka"
  vm_zones                        = ["us-central1-a", "us-central1-b", "us-central1-c"] #provide regions for high availability
  vpc_network_name                = "terraform-network"
  zookeeper_vm_attached_disk_size = 10
  zookeeper_vm_attached_disk_type = "pd-ssd"
  zookeeper_vm_count              = 1
  zookeeper_vm_machine_type       = "f1-micro"
}