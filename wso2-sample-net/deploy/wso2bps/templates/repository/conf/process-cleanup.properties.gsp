##Config Guide https://docs.wso2.com/display/BPS350/Retired+BPEL+Package+Cleanup
##BPS database connection information referred from bps-datasources.xml file
user.timezone=GMT
clientTrustStorePath=<%= key_stores['trust_store']['location'] %>
<% if (enable_secure_vault) %>
clientTrustStorePassword=secretAlias:Carbon.Security.TrustStore.Password
<% } else { %>
clientTrustStorePassword=<%= key_stores['trust_store']['password'] %>
<% } %>
clientTrustStoreType=<%= key_stores['trust_store']['type'] %>
tenant.context=https://localhost:9443
wso2.bps.username=admin
wso2.bps.password=admin
## Set this option true if instances needs to be removed along with processes
delete.instances=false
## Available Filters for Instance States : ACTIVE, COMPLETED, SUSPENDED, TERMINATED, FAILED
## Listing process instances having the defined filter state
process.filterStates=COMPLETED,TERMINATED,FAILED
