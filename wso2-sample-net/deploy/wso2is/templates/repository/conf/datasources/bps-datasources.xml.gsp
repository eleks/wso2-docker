<datasources-configuration xmlns:svns="http://org.wso2.securevault/configuration">
  
   <providers>
        <provider>org.wso2.carbon.ndatasource.rdbms.RDBMSDataSourceReader</provider>
    </providers>
  
  <datasources>      
        <% bps_datasources.each{ datasource_name, datasource-> %>
        <datasource>
            <name><%= datasource_name %></name>
            <description><%= datasource['description'] %></description>
            <jndiConfig>
                <name><%= datasource['jndi_config'] %></name>
            </jndiConfig>
            <definition type="RDBMS">
                <configuration>
                    <url><%= datasource['url'] %></url>
                    <username><%= datasource['username'] %></username>
                    <password><%= datasource['password'] %></password>
                    <driverClassName><%= datasource['driver_class_name'] %></driverClassName>
                    <maxActive><%= datasource['max_active'] %></maxActive>
                    <maxWait><%= datasource['max_wait'] %></maxWait>
                    <testOnBorrow><%= datasource['test_on_borrow'] %></testOnBorrow>
                    <validationQuery><%= datasource['validation_query'] %></validationQuery>
                    <validationInterval><%= datasource['validation_interval'] %></validationInterval>
                    <useDataSourceFactory>false</useDataSourceFactory>
                    <defaultAutoCommit><%= datasource.default_auto_commit %></defaultAutoCommit>
                    <maxIdle>20</maxIdle>
                </configuration>
            </definition>
        </datasource>
        <% } %>
    </datasources>
</datasources-configuration>
