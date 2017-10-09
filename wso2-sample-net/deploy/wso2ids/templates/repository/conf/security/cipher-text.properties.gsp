# By default, This file contains the secret alias names and the plain text passwords enclosed with '[]' brackets
# In Production environments, It is recommend to replace these plain text password by the encrypted values. CipherTool can be used for it.

<% if (!secure_vault_configs) {  %>
Carbon.Security.KeyStore.Password=[<%= key_stores.key_store.password %>]
Carbon.Security.KeyStore.KeyPassword=[<%= key_stores.key_store.key_password %>]
Carbon.Security.TrustStore.Password=[<%= key_stores.trust_store.password %>]
UserManager.AdminUser.Password=[<%= user_management.admin_password %>]
Datasources.WSO2_CARBON_DB.Configuration.Password=[<%= master_datasources.WSO2_CARBON_DB.password %>]
Server.Service.Connector.keystorePass=[<%= key_stores.connector_key_store.password %>]
<% } else { %>
<% secure_vault_configs.each{secure_vault_config_name, secure_vault_config-> %>
<%= secure_vault_config['secret_alias'] %>=[<%= secure_vault_config['password'] %>]
<% } %>
<% } %>
