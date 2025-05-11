locals {
  source_image_id = ""
}

resource "azurerm_linux_virtual_machine_scale_set" "web_vmss" {
  name                = "${local.resource_name_prefix}-web-vmss-${random_string.myrandom.id}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard_D2s_v6"
  instances           = 2
  admin_username      = "azureuser"
  upgrade_mode        = "Automatic"
  secure_boot_enabled = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  source_image_id = local.source_image_id

  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
  }

  identity {
    type = "SystemAssigned"
  }

  network_interface {
    name    = "web-vmss-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.websubnet.id
      application_gateway_backend_address_pool_ids = [
        tolist(azurerm_application_gateway.web_ag.backend_address_pool)[0].id
      ]
    }
  }

  tags = local.common_tags
}

output "web_vmss_id" {
  description = "Web Virtual Machine Scale Set ID"
  value       = azurerm_linux_virtual_machine_scale_set.web_vmss.id
}

# Autoscale configuration
resource "azurerm_monitor_autoscale_setting" "autoscale" {
  name                = "web-vmss-autoscale"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.web_vmss.id

  profile {
    name = "defaultProfile"

    capacity {
      default = 2
      minimum = 2
      maximum = 3
    }

    # Scale-out rule
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 80
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    # Scale-in rule
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 20
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }

  tags = local.common_tags
}
