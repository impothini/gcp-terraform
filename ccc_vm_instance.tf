resource "google_compute_disk" "ccc_disk" {
  count = var.ccc_information.count
  name  = "${var.ccc_information.prefix}-disk-${count.index + 1}"
  type  = "pd-ssd"
  zone  = var.ccc_information.zones[count.index % length(var.ccc_information.zones)]
  # image = "debian-9-stretch-v20200805"
  size = var.ccc_information.disk_size
}

resource "google_compute_instance" "ccc_instance" {
  count        = var.ccc_information.count
  name         = "${var.ccc_information.prefix}-${count.index + 1}"
  machine_type = var.ccc_information.machine_type
  #  hostname     = "${var.ccc_information.prefix}-${count.index + 1}"

  zone = var.ccc_information.zones[count.index % length(var.ccc_information.zones)]

  boot_disk {
    initialize_params {
      image = var.ccc_information.image_name
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }

}

resource "google_compute_attached_disk" "ccc-data-diskattach" {
  count    = var.ccc_information.count
  disk     = "${var.ccc_information.prefix}-disk-${count.index + 1}"
  instance = "${var.ccc_information.prefix}-${count.index + 1}"
  zone     = var.ccc_information.zones[count.index % length(var.ccc_information.zones)]

  depends_on = [google_compute_instance.ccc_instance, google_compute_disk.ccc_disk]
}

