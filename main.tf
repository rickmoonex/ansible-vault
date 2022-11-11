provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vault" {
  name     = "vault"
  location = "West Europe"
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "vault1"
  resource_group_name = azurerm_resource_group.vault.name
  location            = azurerm_resource_group.vault.location
  size                = "Standard_F2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.nic-raft[0].id,
    azurerm_network_interface.nic-external[0].id,
  ]

  admin_password                  = "AzureVm1234!"
  disable_password_authentication = false

  custom_data = data.template_cloudinit_config.config1.rendered

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = "/subscriptions/df7b52cf-72b5-4784-9874-85af8d8adb24/resourceGroups/big-test-rg/providers/Microsoft.Compute/images/packer-test"
}

resource "azurerm_linux_virtual_machine" "vm2" {
  name                = "vault2"
  resource_group_name = azurerm_resource_group.vault.name
  location            = azurerm_resource_group.vault.location
  size                = "Standard_F2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.nic-raft[1].id,
    azurerm_network_interface.nic-external[1].id,
  ]

  admin_password                  = "AzureVm1234!"
  disable_password_authentication = false

  custom_data = data.template_cloudinit_config.config2.rendered

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = "/subscriptions/df7b52cf-72b5-4784-9874-85af8d8adb24/resourceGroups/big-test-rg/providers/Microsoft.Compute/images/packer-test"
}

resource "azurerm_linux_virtual_machine" "vm3" {
  name                = "vault3"
  resource_group_name = azurerm_resource_group.vault.name
  location            = azurerm_resource_group.vault.location
  size                = "Standard_F2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.nic-raft[2].id,
    azurerm_network_interface.nic-external[2].id,
  ]

  admin_password                  = "AzureVm1234!"
  disable_password_authentication = false

  custom_data = data.template_cloudinit_config.config3.rendered

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = "/subscriptions/df7b52cf-72b5-4784-9874-85af8d8adb24/resourceGroups/big-test-rg/providers/Microsoft.Compute/images/packer-test"
}