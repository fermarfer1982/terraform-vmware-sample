variable "vsphere_server" {
  description = "IP o DNS de tu servidor VMware"
  type        = string
}

variable "vsphere_user" {
  description = "Usuario con permisos de acceso a vSphere/ESXi"
  type        = string
}

variable "vsphere_password" {
  description = "Contraseña del usuario de vSphere/ESXi"
  type        = string
  sensitive   = true
}

variable "datacenter_name" {
  description = "Nombre del Datacenter"
  type        = string
}

variable "datastore_name" {
  description = "Datastore donde crear la VM"
  type        = string
}

variable "resource_pool_name" {
  description = "Pool de recursos (si aplica)"
  type        = string
  default     = ""
}

variable "network_name" {
  description = "Port group o red virtual"
  type        = string
}

variable "vm_template_name" {
  description = "Nombre de la plantilla o VM de origen"
  type        = string
}

variable "vm_name" {
  description = "Nombre de la nueva VM"
  type        = string
}

variable "cpu" {
  description = "Número de vCPU"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Tamaño de RAM (MiB)"
  type        = number
  default     = 4096
}

variable "use_dhcp" {
  description = "¿Asignar IP por DHCP?"
  type        = bool
  default     = true
}

variable "vm_ip" {
  description = "IP estática (si use_dhcp = false)"
  type        = string
  default     = ""
}

variable "vm_netmask" {
  description = "Máscara de red (si use_dhcp = false)"
  type        = string
  default     = ""
}

variable "vm_gateway" {
  description = "Puerta de enlace (si use_dhcp = false)"
  type        = string
  default     = ""
}

variable "dns_servers" {
  description = "Lista de DNS (si use_dhcp = false)"
  type        = list(string)
  default     = []
}
