
provider "vault" {

}

resource "vault_generic_secret" "test_secret" {
  path         = "secret/test_secret"
  disable_read = false
  data_json = jsonencode({
    secret_a = "okok"
  })
}