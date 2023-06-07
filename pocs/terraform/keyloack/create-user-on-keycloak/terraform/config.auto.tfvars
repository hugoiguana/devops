
url       = "http://keycloak:8080"
client_id = "admin-cli"
username  = "admin"
password  = "admin"

realm_id = "realm_name"

users_info = {
  "test1" = {
    username            = "test1"
    enabled             = true
    email               = "test1@email.com"
    first_name          = "test1"
    last_name           = "test"
    password            = "test123X"
    password_temporary  = false
    },
  "test2" = {
    username            = "test2"
    enabled             = true
    email               = "test2@email.com"
    first_name          = "test2"
    last_name           = "test"
    password            = "test123X"
    password_temporary  = false
    },
}
