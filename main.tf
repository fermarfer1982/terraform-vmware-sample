terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.5"
    }
  }
}

provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter_name
}

data "vsphere_datastore" "ds" {
  name          = var.datastore_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "rp" {
  name          = var.resource_pool_name != "" ? var.resource_pool_name : data.vsphere_datacenter.dc.id
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "net" {
  name          = var.network_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vm_template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.rp.id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = var.cpu
  memory   = var.memory
  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.net.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.vm_name
        domain    = var.datacenter_name
      }

      network_interface {
        ipv4_address = var.use_dhcp ? "" : var.vm_ip
        ipv4_netmask = var.use_dhcp ? 0 : tonumber(regexreplace(var.vm_netmask, "/.*",""))
      }

      ipv4_gateway    = var.use_dhcp ? "" : var.vm_gateway
      dns_server_list = var.use_dhcp ? [] : var.dns_servers
    }
  }
}

