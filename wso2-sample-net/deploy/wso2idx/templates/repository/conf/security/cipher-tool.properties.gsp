# Important: This properties file contains all the aliases to be used in carbon components. If any property need to be secured, you need to add alias name, file name and the xpath as follows:.
# The value goes as, the <file_name>//<xpath>,<true/false>
# where <file_name> - is the file (along with the file path) to be secured,
#       <xpath> - is the xpath to the property value to be secured
#       <true / false> - This is true if the last parameter in the xpath is parameter (starts with [ and ends with ]) and you want its value to be replaced with "password"

Carbon.Security.KeyStore.Password=repository/conf/carbon.xml//Server/Security/KeyStore/Password,false
Carbon.Security.KeyStore.KeyPassword=repository/conf/carbon.xml//Server/Security/KeyStore/KeyPassword,false
Carbon.Security.TrustStore.Password=repository/conf/carbon.xml//Server/Security/TrustStore/Password,false
UserManager.AdminUser.Password=repository/conf/user-mgt.xml//UserManager/Realm/Configuration/AdminUser/Password,false
Datasources.WSO2_CARBON_DB.Configuration.Password=repository/conf/datasources/master-datasources.xml//datasources-configuration/datasources/datasource[name='WSO2_CARBON_DB']/definition[@type='RDBMS']/configuration/password,false
Server.Service.Connector.keystorePass=repository/conf/tomcat/catalina-server.xml//Server/Service/Connector[@keystorePass],true
Analytics.Data.Config.Password=repository/conf/analytics/analytics-data-config.xml//AnalyticsDataConfiguration/Password,false
DataBridge.Config.keyStorePassword=/repository/conf/data-bridge/data-bridge-config.xml//dataBridgeConfiguration/keyStorePassword,true
#Analytics.Data.Config.TrustStorePassword=repository/conf/analytics/analytics-data-config.xml//AnalyticsDataConfiguration/TrustStorePassword,false
#Carbon.DeploymentSynchronizer.SvnPassword=repository/conf/carbon.xml//Sever/DeploymentSynchronizer/SvnPassword,false
#UserStoreManager.Property.ConnectionPassword=repository/conf/user-mgt.xml//UserManager/Realm/UserStoreManager/Property[@name='ConnectionPassword'],false
#UserStoreManager.Property.password=repository/conf/user-mgt.xml//UserManager/Realm/UserStoreManager/Property[@name='password'],false
#Security.UserTrustedRPStore.Password=repository/conf/identity.xml//Server/Security/UserTrustedRPStore/Password,false
#Security.UserTrustedRPStore.KeyPassword=repository/conf/identity.xml//Server/Security/UserTrustedRPStore/KeyPassword,false
#MultifactorAuthentication.XMPPSettings.XMPPConfig.XMPPPassword=repository/conf/identity.xml//MultifactorAuthentication/XMPPSettings/XMPPConfig/XMPPPassword,false
#Identity.System.StorePass=repository/conf/identity.xml//Server/Identity/System/StorePass,false
#Axis2.Https.Listener.TrustStore.Password=repository/conf/axis2/axis2.xml//axisconfig/transportReceiver[@name='https']/parameter[@name='truststore']/TrustStore/Password,false
#Axis2.Https.Listener.KeyStore.Password=repository/conf/axis2/axis2.xml//axisconfig/transportReceiver[@name='https']/parameter[@name='keystore']/KeyStore/Password,false
#Axis2.Https.Listener.KeyStore.KeyPassword=repository/conf/axis2/axis2.xml//axisconfig/transportReceiver[@name='https']/parameter[@name='keystore']/KeyStore/KeyPassword,false
#Axis2.Https.Sender.TrustStore.Password=repository/conf/axis2/axis2.xml//axisconfig/transportSender[@name='https']/parameter[@name='truststore']/TrustStore/Password,false
#Axis2.Https.Sender.KeyStore.Password=repository/conf/axis2/axis2.xml//axisconfig/transportSender[@name='https']/parameter[@name='keystore']/KeyStore/Password,false
#Axis2.Https.Sender.KeyStore.KeyPassword=repository/conf/axis2/axis2.xml//axisconfig/transportSender[@name='https']/parameter[@name='keystore']/KeyStore/KeyPassword,false
#Axis2.Mailto.Parameter.Password=repository/conf/axis2/axis2.xml//axisconfig/transportSender[@name='mailto']/parameter[@name='mail.smtp.password'],false