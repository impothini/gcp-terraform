resource "google_compute_disk" "zk_disk" {
  count = var.zk_information.count
  name  = "${var.zk_information.prefix}-disk-${count.index + 1}"
  type  = "pd-ssd"
  zone  = var.zk_information.zones[count.index % length(var.zk_information.zones)]
  size  = var.zk_information.disk_size
}

resource "google_compute_instance" "zk_instance" {
  count        = var.zk_information.count
  name         = "${var.zk_information.prefix}-${count.index + 1}"
  machine_type = var.zk_information.machine_type

  #  attached_disk {
  #    source = "${var.zk_information.prefix}-disk-${count.index + 1}"
  #  }

  zone = var.zk_information.zones[count.index % length(var.zk_information.zones)]

  boot_disk {
    initialize_params {
      image = var.zk_information.image_name
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

resource "google_compute_attached_disk" "zk-data-diskattach" {
  count    = var.zk_information.count
  disk     = "${var.zk_information.prefix}-disk-${count.index + 1}"
  instance = "${var.zk_information.prefix}-${count.index + 1}"
  zone     = var.zk_information.zones[count.index % length(var.zk_information.zones)]

  depends_on = [google_compute_instance.zk_instance, google_compute_disk.zk_disk]

}