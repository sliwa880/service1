locals {
  location = "uksouth"
}

resource "azurerm_resource_group" "service1_rg" {
  name     = "sat-service1-${local.location}-rg"
  location = local.location
}

data "azurerm_resource_group" "core_rg" {
  name = "sat-core-${var.environment}-${local.location}-rg"
}

data "azurerm_container_app_environment" "container_app_environment" {
  name                = "sat-${var.environment}-${local.location}-cae"
  resource_group_name = data.azurerm_resource_group.core_rg.name
}

module "container_app" {
  source = "../../../terraform-modules/container_app"

  product_name                 = "sat"
  service_name                 = "service1"
  location                     = local.location
  environment                  = var.environment
  resource_group_name          = azurerm_resource_group.service1_rg.name
  resource_group_id            = azurerm_resource_group.service1_rg.id
  container_app_environment_id = data.azurerm_container_app_environment.container_app_environment.id
  image_repository             = var.image_repository
  image_tag                    = var.image_tag
  resources                    = var.resources
  scale                        = var.uksouth_scale
  tags = {
    "service_name" = "service1"
  }
}
