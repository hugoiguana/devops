
resource "keycloak_user" "user" {

  for_each = var.users_info

  realm_id   = var.realm_id
  username = each.value.username
  enabled    = each.value.enabled
  email      = each.value.email
  first_name = each.value.first_name
  last_name  = each.value.last_name

  initial_password {
    value     = each.value.password
    temporary = each.value.password_temporary
  }
}
