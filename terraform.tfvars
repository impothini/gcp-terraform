
gcp_cred_file = "gcpLearn.json"

gcp_region = "us-central1"

gcp_zone = "us-central1-c"

gcp_project = "lyrical-marker-362301"

vpc_network_name = "terraform-network"

broker_information = {
  prefix       = "kafka-broker-instance"
  image_name   = "centos-7-v20220822"
  count        = 3 #Number of servers to provisions
  machine_type = "f1-micro"
  zones        = ["us-central1-a", "us-central1-b", "us-central1-c"] #provide regions for high availability
  disk_size    = 10                                                  #disk size in GB
}

zk_information = {
  prefix       = "kafka-zk-instance"
  image_name   = "centos-7-v20220822"
  count        = 2 #Number of servers to provisions
  machine_type = "f1-micro"
  zones        = ["us-central1-a", "us-central1-b", "us-central1-c"] #provide regions for high availability
  disk_size    = 10                                                  #disk size in GB
}

ccc_information = {
  prefix       = "kafka-ccc-instance"
  image_name   = "centos-7-v20220822"
  count        = 1 #Number of servers to provisions
  machine_type = "f1-micro"
  zones        = ["us-central1-a", "us-central1-b", "us-central1-c"] #provide regions for high availability
  disk_size    = 10                                                  #disk size in GB
}