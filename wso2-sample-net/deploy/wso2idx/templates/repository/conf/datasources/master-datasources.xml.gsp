<datasources-configuration xmlns:svns="http://org.wso2.securevault/configuration">
  
    <providers>
        <provider>org.wso2.carbon.ndatasource.rdbms.RDBMSDataSourceReader</provider>
    </providers>
  
    <datasources>
<% master_datasources.each{dsn, ds-> render("datasource.gspx/RDBMS.gspx", [out:out, dsn:dsn, ds:ds]) } %>

        <!-- For an explanation of the properties, see: http://people.apache.org/~fhanik/jdbc-pool/jdbc-pool.html -->
        <!--datasource>
            <name>SAMPLE_DATA_SOURCE</name>
            <jndiConfig>
                <name></name>
                <environment>
                    <property name="java.naming.factory.initial"></property>
                    <property name="java.naming.provider.url"></property>
                </environment>
            </jndiConfig>
            <definition type="RDBMS">
                <configuration>

                    <defaultAutoCommit></defaultAutoCommit>
                    <defaultReadOnly></defaultReadOnly>
                    <defaultTransactionIsolation>NONE|READ_COMMITTED|READ_UNCOMMITTED|REPEATABLE_READ|SERIALIZABLE</defaultTransactionIsolation>
                    <defaultCatalog></defaultCatalog>
                    <username></username>
                    <password svns:secretAlias="WSO2.DB.Password"></password>
                    <maxActive></maxActive>
                    <maxIdle></maxIdle>
                    <initialSize></initialSize>
                    <maxWait></maxWait>

                    <dataSourceClassName>com.mysql.jdbc.jdbc2.optional.MysqlXADataSource</dataSourceClassName>
                    <dataSourceProps>
                        <property name="url">jdbc:mysql://localhost:3306/Test1</property>
                        <property name="user">root</property>
                        <property name="password">123</property>
                    </dataSourceProps>

                </configuration>
            </definition>
        </datasource-->

    </datasources>

</datasources-configuration>
