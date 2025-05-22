output "vm_id" {
  description = "ID de la VM creada"
  value       = vsphere_virtual_machine.vm.id
}

output "vm_ip_address" {
  description = "IP asignada a la VM"
  value       = var.use_dhcp ? "DHCP" : var.vm_ip
}
