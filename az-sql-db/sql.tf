
# These resources are deprecated. Instead there are dedicated server and db resource available

# create an az sql server
resource "azurerm_sql_server" "demo_sql_server" {
  name                         = "${random_string.prefix.result}-demo-sql-server"
  resource_group_name          = azurerm_resource_group.demo_rg.name
  location                     = azurerm_resource_group.demo_rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = random_password.password.result
}

# create an az sql database
resource "azurerm_sql_database" "demo_sql_db" {
  name                = "${azurerm_sql_server.demo_sql_server.name}-demo-sql-db"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  server_name         = azurerm_sql_server.demo_sql_server.name
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 1
}

# create a firewall rule for the server that allows access from any IP address
resource "azurerm_sql_firewall_rule" "demo_sql_firewall_rule" {
  name                = "AllowAllWindowsAzureIps"
  resource_group_name = azurerm_resource_group.demo_rg.name
  server_name         = azurerm_sql_server.demo_sql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address = "0.0.0.0"
}