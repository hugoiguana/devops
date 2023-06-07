

variable "url" {
  type        = string
  description = "Keycloak URL"
  default     = "http://keycloak:8080"
}

variable "client_id" {
  type        = string
  description = "Keycloak Admin Client id"
  default     = ""
}

variable "username" {
  type        = string
  description = "Keycloak username with permissions to insert Users on the Realm"
  default     = "admin"
}

variable "password" {
  type        = string
  description = "Keycloak user password with permissions to insert Users on the Realm"
  default     = "admin"
}

variable "realm_id" {
  type        = string
  description = "Reaml id"
}

variable "users_info" {
  type = map(object({
    username            = string
    enabled             = bool
    email               = string
    first_name          = string
    last_name           = string
    password            = string
    password_temporary  = bool
  }))
  default = {}
}
