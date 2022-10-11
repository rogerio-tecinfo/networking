variable "resourcegroup" {
  type        = string
  description = "Resource Group used for all resources."
  default     = "az104-04a-rg1"
}

variable "location" {
  type        = string
  description = "Resource Group used for all resources."
  default     = "eastus2"
}

variable "vnet1" {
  type        = string
  description = "Virtual network Name used for all resources"
  default     = "az104-04-vnet01"
}

variable "subnet0" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "Subnet0"
}

variable "subnet1" {
  type        = string
  description = "Subnet Network Name used for all resources"
  default     = "Subnet1"
}

variable "vnetaddress_space" {
  type        = string
  description = "Address space used for all resources. Recommend subnet config /20"
  default     = "10.40.0.0/20"
}

variable "subnetaddress_prefixes0" {
  type        = string
  description = "Subnet network used for all resources. Recommend subnet config /24"
  default     = "10.40.0.0/24"
}

variable "subnetaddress_prefixes1" {
  type        = string
  description = "Subnet network used for all resources. Recommend subnet config /24"
  default     = "10.40.1.0/24"
}

variable "nic0" {
  type        = string
  description = "Virtual Network Interface Name."
  default     = "az104-08-nic0"
}

variable "nic1" {
  type        = string
  description = "Virtual Network Interface Name."
  default     = "az104-08-nic1"
}

variable "publicip0" {
  type        = string
  description = "Publicip used for two virtual machines."
  default     = "az104-04-pip0"
}

variable "publicip1" {
  type        = string
  description = "Publicip used for two virtual machines."
  default     = "az104-04-pip1"
}

variable "publicip_sku" {
  type        = string
  description = "The public IP sku: Default Basic"
  default     = "Basic"
}

variable "nsg" {
  type        = string
  description = "Network Security Group Name used for all resources"
  default     = "az104-04-nsg1"
}

variable "private_domain_name" {
  type        = string
  description = "Private DNS Service Domain"
  default     = "tisolution.local"
}

variable "domain_name" {
  type        = string
  description = "DNS Service Domain"
  default     = "tisolution.tech"
}

variable "dns_zone_link" {
  type        = string
  description = "DNS Service Domain"
  default     = "az104-04-vnet1-link"
}

variable "size" {
  type        = string
  description = "Virtual Machine size, Default: Standard_DS1_v2"
  default     = "Standard_B2s"
}

variable "storage_account_type" {
  type        = string
  description = "Virtual Machine Disk type, Default: Standard_LRS"
  default     = "Standard_LRS"
}

variable "name0" {
  type        = string
  description = "Virtual Machine Name."
  default     = "az104-04-vm0"
}

variable "name1" {
  type        = string
  description = "Virtual Machine Name."
  default     = "az104-04-vm1"
}

variable "source_image_reference_publisher" {
  type        = string
  description = "Virtual Machine Publisher, Default: MicrosoftWindowsServer"
  default     = "MicrosoftWindowsServer"
}

variable "source_image_reference_offer" {
  type        = string
  description = "Virtual Machine Offer, Default: WindowsServer"
  default     = "WindowsServer"
}

variable "source_image_reference_sku" {
  type        = string
  description = "Virtual Machine Sku, Default: 2019-Datacenter"
  default     = "2019-Datacenter"
}

variable "source_image_reference_version" {
  type        = string
  description = "Virtual Machine Version, Default: latest"
  default     = "latest"
}

variable "user" {
  type        = string
  description = "User Name to connect on the VM."
  default     = "lab.azuser"
}

variable "password" {
  type        = string
  description = "password to connect on the VM."
  default     = "Q1w2e3r4t5%y"
}



