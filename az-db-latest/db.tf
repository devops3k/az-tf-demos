# Azure MSSQL Server
resource "azurerm_mssql_server" "demo_sql_server" {
  name                         = "${random_string.prefix.result}-demo-sql-server"
  resource_group_name          = azurerm_resource_group.demo_rg.name
  location                     = azurerm_resource_group.demo_rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = random_password.password.result
}

# Azure MSSQL Server Firewall Rule`
resource "azurerm_mssql_firewall_rule" "demo_sql_db" {
  name             = "AllowAllWindowsAzureIps"
  server_id        = azurerm_mssql_server.demo_sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Azure MSSQL Database
resource "azurerm_mssql_database" "demo_sql_firewall_rule" {
  name           = "${azurerm_mssql_server.demo_sql_server.name}-demo-sql-db"
  server_id      =  azurerm_mssql_server.demo_sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  sku_name       = "Basic"
}