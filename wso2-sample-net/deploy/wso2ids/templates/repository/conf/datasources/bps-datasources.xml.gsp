<datasources-configuration xmlns:svns="http://org.wso2.securevault/configuration">
  
    <providers>
        <provider>org.wso2.carbon.ndatasource.rdbms.RDBMSDataSourceReader</provider>
    </providers>
  
    <datasources>      
<% bps_datasources.each{dsn, ds-> context.render("/datasource.gspx/RDBMS.gspx", [out:out, dsn:dsn, ds:ds]) } %>
    </datasources>
</datasources-configuration>
