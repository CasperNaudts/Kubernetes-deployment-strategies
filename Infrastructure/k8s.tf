resource "azurerm_resource_group" "k8s" {
    name     = "research-k8s"
    location = "West Europe"

    tags = {
        Project = "Research"
    }
}

resource "azurerm_container_registry" "acr" {
    name                     = "researchk8s"
    resource_group_name      = azurerm_resource_group.k8s.name
    location                 = azurerm_resource_group.k8s.location
    sku                      = "Basic"
    admin_enabled            = false
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                = "research-k8s"
    location            = azurerm_resource_group.k8s.location
    resource_group_name = azurerm_resource_group.k8s.name
    dns_prefix          = "research"
    kubernetes_version  = "1.16.7"

    default_node_pool {
        name       = "agentpool"
        vm_size    = "Standard_B2s"
        enable_auto_scaling = true
        max_count  = 3
        min_count  = 1
    }

    identity {
        type = "SystemAssigned"
    }

    tags = {
        Project = "Research"
    }
}