output "server_password" {
  value = random_password.password.result
  sensitive = true 
}

output "server_name" {
  value = azurerm_sql_server.demo_sql_server.name
}

output "server_login" {
  value = azurerm_sql_server.demo_sql_server.administrator_login
}

output "server_fqdn" {
  value = azurerm_sql_server.demo_sql_server.fully_qualified_domain_name
}
