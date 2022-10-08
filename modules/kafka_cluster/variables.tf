
variable "gcp_region" {
  type = string
}

variable "gcp_zone" {
  type = string
}

variable "gcp_project" {
  type = string
}

variable "vpc_network_name" {
  type = string
}

variable "vm_name_prefix" {
  type = string
}

variable "vm_image_name" {
  type = string
}

variable "vm_zones" {
  type = list(string)
}

variable "vm_labels" {
  type = map(string)
}

variable "broker_vm_attached_disk_size" {
  type = number
}
variable "broker_vm_attached_disk_type" {
  type = string
}
variable "broker_vm_count" {
  type = number
}
variable "broker_vm_machine_type" {
  type = string
}

variable "zookeeper_vm_attached_disk_size" {
  type = number
}
variable "zookeeper_vm_attached_disk_type" {
  type = string
}
variable "zookeeper_vm_count" {
  type = number
}
variable "zookeeper_vm_machine_type" {
  type = string
}

variable "ccc_vm_attached_disk_size" {
  type = number
}
variable "ccc_vm_attached_disk_type" {
  type = string
}
variable "ccc_vm_count" {
  type = number
}
variable "ccc_vm_machine_type" {
  type = string
}