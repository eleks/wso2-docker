# This is the default file based secret repository, used by Secret Manager of synapse secure vault
# By default, This file contains the secret alias names Vs the plain text passwords enclosed with '[]' brackets
# In Production environments, It is recommend to replace those plain text password by the encrypted values. CipherTool can be used for it.


<% if (!secure_vault_configs) {  %>
Carbon.Security.KeyStore.Password=[<%= key_stores.key_store.password %>]
Carbon.Security.KeyStore.KeyPassword=[<%= key_stores.key_store.key_password %>]
Carbon.Security.TrustStore.Password=[<%= key_stores.trust_store.password %>]
UserManager.AdminUser.Password=[<%= user_management.admin_password %>]
Datasources.WSO2_CARBON_DB.Configuration.Password=[<%= master_datasources.WSO2_CARBON_DB.configuration.password %>]
Server.Service.Connector.keystorePass=[<%= key_stores.connector_key_store.password %>]
Analytics.Data.Config.Password=[admin]
DataBridge.Config.keyStorePassword=[<%= key_stores.key_store.key_password %>]
<% } else { %>
<% secure_vault_configs.each{secure_vault_config_name, secure_vault_config-> %>
<%= secure_vault_config['secret_alias'] %>=[<%= secure_vault_config['password'] %>]
<% } %>
<% } %>

#Analytics.Data.Config.TrustStorePassword=[wso2carbon]
#Carbon.DeploymentSynchronizer.SvnPassword=[password]
#UserStoreManager.Property.ConnectionPassword=[admin]
#UserStoreManager.Property.password=[admin]
#Security.UserTrustedRPStore.Password=[wso2carbon]
#Security.UserTrustedRPStore.KeyPassword=[wso2carbon]
#MultifactorAuthentication.XMPPSettings.XMPPConfig.XMPPPassword=[wso2carbon]
#Identity.System.StorePass=[wso2carbon]
#Axis2.Https.Listener.TrustStore.Password=[wso2carbon]
#Axis2.Https.Listener.KeyStore.Password=[wso2carbon]
#Axis2.Https.Listener.KeyStore.KeyPassword=[wso2carbon]
#Axis2.Https.Sender.TrustStore.Password=[wso2carbon]
#Axis2.Https.Sender.KeyStore.Password=[wso2carbon]
#Axis2.Https.Sender.KeyStore.KeyPassword=[wso2carbon]
#Axis2.Mailto.Parameter.Password=[wso2carbon]