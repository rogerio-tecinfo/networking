# # Create resource group
# resource "azurerm_resource_group" "resourcegroup" {
#   name     = var.resourcegroup
#   location = var.location
# }

# Create resource group
data "azurerm_resource_group" "resourcegroup" {
  name = var.resourcegroup
}

output "resourcegroup_id" {
  value = data.azurerm_resource_group.resourcegroup.id
}

# Create virtual network1
resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1
  address_space       = [var.vnetaddress_space]
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  depends_on          = [data.azurerm_resource_group.resourcegroup]
}

# Create subnet0
resource "azurerm_subnet" "subnet0" {
  name                 = var.subnet0
  resource_group_name  = data.azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.subnetaddress_prefixes0]
  depends_on           = [data.azurerm_resource_group.resourcegroup, azurerm_virtual_network.vnet1]
}

# Create subnet1
resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1
  resource_group_name  = data.azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.subnetaddress_prefixes1]
  depends_on           = [data.azurerm_resource_group.resourcegroup, azurerm_virtual_network.vnet1]
}

# Create network interface to both vms
resource "azurerm_network_interface" "nic0" {
  name                = var.nic0
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "${var.name0}nicconfiguration"
    subnet_id                     = azurerm_subnet.subnet0.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip0.id
  }
  depends_on = [azurerm_subnet.subnet0]
}
resource "azurerm_network_interface" "nic1" {
  name                = var.nic1
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "${var.name1}nicconfiguration"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip1.id
  }
  depends_on = [azurerm_subnet.subnet1]
}

# Create public IPs
resource "azurerm_public_ip" "publicip0" {
  name                = var.publicip0
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  allocation_method   = "Dynamic"
  sku                 = var.publicip_sku
  depends_on          = [azurerm_subnet.subnet0]
  tags = {
    environment = "staging"
  }
}

# Create public IPs
resource "azurerm_public_ip" "publicip1" {
  name                = var.publicip1
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  allocation_method   = "Dynamic"
  sku                 = var.publicip_sku
  depends_on          = [azurerm_subnet.subnet1]
  tags = {
    environment = "staging"
  }
}

#Create Network Security Group and rule to open port 3389.
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name

  security_rule {
    name                       = "AllowRDPInBound"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }

  depends_on = [azurerm_public_ip.publicip0, azurerm_public_ip.publicip1]
}

# Associate the publicip's with the VM nic's 
resource "azurerm_network_interface_security_group_association" "connectnic0" {
  network_interface_id      = azurerm_network_interface.nic0.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on = [azurerm_network_interface.nic0, azurerm_network_security_group.nsg,
  azurerm_public_ip.publicip0]
}

resource "azurerm_network_interface_security_group_association" "connectnic1" {
  network_interface_id      = azurerm_network_interface.nic1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on = [azurerm_network_interface.nic1, azurerm_network_security_group.nsg,
  azurerm_public_ip.publicip1]
}

# Create Private DNS Zone
resource "azurerm_private_dns_zone" "private_domain_name" {
  name                = var.private_domain_name
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  depends_on          = [data.azurerm_resource_group.resourcegroup]
}

resource "azurerm_private_dns_a_record" "private_dns_a_record0" {
  name                = var.name0
  zone_name           = azurerm_private_dns_zone.private_domain_name.name
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  ttl                 = 300
  records             = ["10.40.0.4"]
  depends_on          = [azurerm_private_dns_zone.private_domain_name]
}

resource "azurerm_private_dns_a_record" "private_dns_a_record1" {
  name                = var.name1
  zone_name           = azurerm_private_dns_zone.private_domain_name.name
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  ttl                 = 300
  records             = ["10.40.0.5"]
  depends_on          = [azurerm_private_dns_zone.private_domain_name]
}

# Link between Private DNS Zone and Subnet
resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_link" {
  name                  = var.dns_zone_link
  resource_group_name   = data.azurerm_resource_group.resourcegroup.name
  private_dns_zone_name = azurerm_private_dns_zone.private_domain_name.name
  virtual_network_id    = azurerm_virtual_network.vnet1.id
  depends_on            = [azurerm_virtual_network.vnet1, azurerm_private_dns_zone.private_domain_name]
}

# Create DNS Zone
data "azurerm_dns_zone" "domain_name" {
  name                = var.domain_name
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
}

output "dns_zone_id" {
  value = data.azurerm_dns_zone.domain_name.id
}

resource "azurerm_dns_a_record" "dns_a_record0" {
  name                = var.name0
  zone_name           = data.azurerm_dns_zone.domain_name.name
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  target_resource_id  = azurerm_public_ip.publicip0.id
  ttl                 = 1
}

resource "azurerm_dns_a_record" "dns_a_record1" {
  name                = var.name1
  zone_name           = data.azurerm_dns_zone.domain_name.name
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  target_resource_id  = azurerm_public_ip.publicip1.id
  ttl                 = 1
}

# Create virtual machines
resource "azurerm_windows_virtual_machine" "name0" {
  name                  = var.name0
  location              = data.azurerm_resource_group.resourcegroup.location
  resource_group_name   = data.azurerm_resource_group.resourcegroup.name
  network_interface_ids = [azurerm_network_interface.nic0.id]
  size                  = var.size

  os_disk {
    name                 = "${var.name0}_osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  computer_name  = var.name0
  admin_username = var.user
  admin_password = var.password
  #    disable_password_authentication = true

  depends_on = [azurerm_subnet.subnet0]
}

resource "azurerm_windows_virtual_machine" "name1" {
  name                  = var.name1
  location              = data.azurerm_resource_group.resourcegroup.location
  resource_group_name   = data.azurerm_resource_group.resourcegroup.name
  network_interface_ids = [azurerm_network_interface.nic1.id]
  size                  = var.size

  os_disk {
    name                 = "${var.name1}_osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  computer_name  = var.name1
  admin_username = var.user
  admin_password = var.password
  #    disable_password_authentication = true

  depends_on = [azurerm_windows_virtual_machine.name0, azurerm_subnet.subnet1]
}
