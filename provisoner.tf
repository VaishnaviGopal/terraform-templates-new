provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

variable "ibmcloud_api_key" {}
variable "region" {
  default = "us-south"
}
variable "vpc_name" {
  default = "example-vpc-v"
}

resource "ibm_is_vpc" "example_vpc" {
  name = var.vpc_name
}

resource "ibm_is_subnet" "example_subnet" {
  name            = "example-subnet"
  vpc             = ibm_is_vpc.example_vpc.id
  zone            = "${var.region}-1"
  ip_version      = "ipv4"
  cidr            = "10.0.0.0/24"
  resource_group  = "default"
}

resource "ibm_is_instance" "example_instance" {
  name              = "example-instance"
  profile           = "bx2-2x8"
  vpc               = ibm_is_vpc.example_vpc.id
  zone              = "${var.region}-1"
  image             = "ibm-ubuntu-22-04-2-minimal-amd64-2"
  primary_network_interface {
    subnet = ibm_is_subnet.example_subnet.id
  }
  keys = [
    var.ssh_public_key
  ]
}

variable "ssh_public_key" {
  description = "SSH public key for the instance"
}

variable "ssh_private_key" {
  description = "SSH private key for the instance"
  sensitive   = true
}

resource "null_resource" "local_exec_example" {
  provisioner "local-exec" {
    command = "echo 'Hello, World from local-exec!'"
  }
}

resource "null_resource" "remote_exec_example" {
  depends_on = [ibm_is_instance.example_instance]

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello, World from remote-exec on IBM Cloud VSI!'"
    ]

    connection {
      type        = "ssh"
      host        = ibm_is_instance.example_instance.primary_network_interface[0].primary_ipv4_address
      user        = "ubuntu"
      private_key = var.ssh_private_key
    }
  }
}
