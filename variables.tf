
variable "gcp_cred_file" {
  type = string
}

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

variable "ssh_pub_key" {
  type = string
}

variable "broker_information" {
  type = object({
    prefix       = string
    image_name   = string
    machine_type = string
    count        = number
    zones        = list(string)
    disk_size    = number
  })
}

variable "zk_information" {
  type = object({
    prefix       = string
    image_name   = string
    machine_type = string
    count        = number
    zones        = list(string)
    disk_size    = number
  })
}

variable "ccc_information" {
  type = object({
    prefix       = string
    image_name   = string
    machine_type = string
    count        = number
    zones        = list(string)
    disk_size    = number
  })
  sensitive = true
}
