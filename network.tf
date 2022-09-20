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