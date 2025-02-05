provider "azurerm" {
  features {}
}

terraform {
  backend  "azurerm"  {
    resource_group_name = "gr01-devops"
    storage_account_name = "STORAGE_ACCOUNT_NAME"
    container_name       = "CONTAINER_NAME"
    key                  = "key"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "gr04-devops"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "aks-service-ccu"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "aks1"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled = false
    }
  }
}
