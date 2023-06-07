terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "3.9.1"
    }
  }
}

provider "keycloak" {
  client_id = var.client_id
  username  = var.username
  password  = var.password
  url       = var.url
}