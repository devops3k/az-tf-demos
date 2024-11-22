resource "random_password" "password" {
  length  = 16
  special = true
  lower   = true
  upper   = true
  numeric = true
}

resource "random_string" "prefix" {
  length  = 4
  special = false
  upper = false
}