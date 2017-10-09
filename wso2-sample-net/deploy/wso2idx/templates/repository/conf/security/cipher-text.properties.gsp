# This is the default file based secret repository, used by Secret Manager of synapse secure vault
# By default, This file contains the secret alias names Vs the plain text passwords enclosed with '[]' brackets
# In Production environments, It is recommend to replace those plain text password by the encrypted values. CipherTool can be used for it.



Carbon.Security.KeyStore.Password=[wso2carbon]
Carbon.Security.KeyStore.KeyPassword=[wso2carbon]
Carbon.Security.TrustStore.Password=[wso2carbon]
UserManager.AdminUser.Password=[admin]
Datasources.WSO2_CARBON_DB.Configuration.Password=[wso2carbon]
Server.Service.Connector.keystorePass=[wso2carbon]
Analytics.Data.Config.Password=[admin]
DataBridge.Config.keyStorePassword=[wso2carbon]
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