provider "azurerm" {
  features {}
}

terraform {
  backend  "azurerm"  {
    storage_account_name = "backendccu"
    container_name = "terraform"
    access_key = "x3I1gJRGUBGG6GbBEoYg2xQLsA78Gm/BV+ifWz5oFTnyBa6Hy9rey+GpwQSJud8el7++xluYp4AClCF57l14aw=="
    key = "terraform.tfstate"
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
