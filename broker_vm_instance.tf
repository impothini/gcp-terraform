#resource "google_compute_address" "static_ip" {
#  count = var.broker_information.count
#  name  = "${var.broker_information.prefix}-staticIp-${count.index + 1}"
#}

resource "google_compute_disk" "broker_disk" {
  count = var.broker_information.count
  name  = "${var.broker_information.prefix}-disk-${count.index + 1}"
  type  = "pd-ssd"
  zone  = var.broker_information.zones[count.index % length(var.broker_information.zones)]
  # image = "debian-9-stretch-v20200805"
  size = var.broker_information.disk_size
}

resource "google_compute_instance" "broker_instance" {
  count        = var.broker_information.count
  name         = "${var.broker_information.prefix}-${count.index + 1}"
  machine_type = var.broker_information.machine_type
  #  hostname     = "${var.broker_information.prefix}-${count.index + 1}"

  #  attached_disk {
  #    source = "${var.broker_information.prefix}-disk-${count.index + 1}"
  #  }

  zone = var.broker_information.zones[count.index % length(var.broker_information.zones)]

  boot_disk {
    initialize_params {
      image = var.broker_information.image_name
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

  metadata = {
    ssh-keys = "kafka:${file("keys/id_rsa.pub")}"
  }


}

output "ext_ip" {
  #  count    = var.broker_information.count
  value = google_compute_instance.broker_instance[0].network_interface[0].access_config[0].nat_ip

  provisioner "local-exec" {
    command = "ansible-playbook -i ${google_compute_instance.broker_instance[0].network_interface[0].access_config[0].nat_ip}, ansible/createFileSystem.yml --private-key=keys/id_rsa --user=kafka"
  }

  depends_on = [google_compute_attached_disk.broker-data-diskattach]
}

resource "google_compute_attached_disk" "broker-data-diskattach" {
  count    = var.broker_information.count
  disk     = "${var.broker_information.prefix}-disk-${count.index + 1}"
  instance = "${var.broker_information.prefix}-${count.index + 1}"
  zone     = var.broker_information.zones[count.index % length(var.broker_information.zones)]

  depends_on = [google_compute_disk.broker_disk, google_compute_instance.broker_instance]

}

