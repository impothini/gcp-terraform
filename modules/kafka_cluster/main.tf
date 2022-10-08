
module "broker_vm" {

  source = "../gcp_vm"


  gcp_project = var.gcp_project
  gcp_region  = var.gcp_region
  gcp_zone    = var.gcp_zone

  vm_attached_disk_size = var.broker_vm_attached_disk_size
  vm_attached_disk_type = var.broker_vm_attached_disk_type
  vm_count              = var.broker_vm_count
  vm_image_name         = var.vm_image_name
  vm_labels = merge(tomap({
    kafkaservice = "broker"
    }),
    var.vm_labels,
  )
  vm_machine_type  = var.broker_vm_machine_type
  vm_name_prefix   = "${var.vm_name_prefix}-broker"
  vm_zones         = var.vm_zones
  vpc_network_name = var.vpc_network_name
}

module "zookeeper_vm" {

  source = "../gcp_vm"


  gcp_project = var.gcp_project
  gcp_region  = var.gcp_region
  gcp_zone    = var.gcp_zone

  vm_attached_disk_size = var.zookeeper_vm_attached_disk_size
  vm_attached_disk_type = var.zookeeper_vm_attached_disk_type
  vm_count              = var.zookeeper_vm_count
  vm_image_name         = var.vm_image_name
  vm_labels = merge(tomap({
    kafkaservice = "zookeeper"
    }),
    var.vm_labels,
  )
  vm_machine_type  = var.zookeeper_vm_machine_type
  vm_name_prefix   = "${var.vm_name_prefix}-zookeeper"
  vm_zones         = var.vm_zones
  vpc_network_name = var.vpc_network_name
}


module "ccc_vm" {

  source = "../gcp_vm"


  gcp_project = var.gcp_project
  gcp_region  = var.gcp_region
  gcp_zone    = var.gcp_zone

  vm_attached_disk_size = var.ccc_vm_attached_disk_size
  vm_attached_disk_type = var.ccc_vm_attached_disk_type
  vm_count              = var.ccc_vm_count
  vm_image_name         = var.vm_image_name
  vm_labels = merge(tomap({
    kafkaservice = "controlcenter"
    }),
    var.vm_labels,
  )
  vm_machine_type  = var.ccc_vm_machine_type
  vm_name_prefix   = "${var.vm_name_prefix}-ccc"
  vm_zones         = var.vm_zones
  vpc_network_name = var.vpc_network_name
}