resource "google_compute_disk" "gcp_vm_disk" {
  count = var.vm_count
  name  = "${var.vm_name_prefix}-disk-${count.index + 1}"
  type  = var.vm_attached_disk_type
  zone  = var.vm_zones[count.index % length(var.vm_zones)]
  size  = var.vm_attached_disk_size

  labels = var.vm_labels

  depends_on = [google_compute_instance.gcp_vm]
}

resource "google_compute_instance" "gcp_vm" {

  count        = var.vm_count
  name         = "${var.vm_name_prefix}-${count.index + 1}"
  machine_type = var.vm_machine_type


  zone = var.vm_zones[count.index % length(var.vm_zones)]

  boot_disk {
    initialize_params {
      image = var.vm_image_name
    }
  }

  network_interface {
    network = var.vpc_network_name

  }

  lifecycle {
    ignore_changes = [attached_disk]
  }

  metadata = {
    ssh-keys = "kafka:${file("${path.module}/keys/id_rsa.pub")}"
  }


}

#output "ext_ip" {
#  value = google_compute_instance.broker_instance[0].network_interface[0].access_config[0].nat_ip
#
#  provisioner "local-exec" {
#    command = "ansible-playbook -i ${google_compute_instance.broker_instance[0].network_interface[0].access_config[0].nat_ip}, ansible/createFileSystem.yml --private-key=keys/id_rsa --user=kafka"
#  }
#
#  depends_on = [google_compute_attached_disk.broker-data-diskattach]
#}

resource "google_compute_attached_disk" "gcp_vm_data_diskattach" {
  count    = var.vm_count
  disk     = "${var.vm_name_prefix}-disk-${count.index + 1}"
  instance = "${var.vm_name_prefix}-${count.index + 1}"
  zone     = var.vm_zones[count.index % length(var.vm_zones)]

  depends_on = [google_compute_disk.gcp_vm_disk, google_compute_instance.gcp_vm]

}
