<datasources-configuration xmlns:svns="http://org.wso2.securevault/configuration">
  
    <providers>
        <provider>org.wso2.carbon.ndatasource.rdbms.RDBMSDataSourceReader</provider>
    </providers>
  
    <datasources>
      
        <datasource>
            <name>WSO2_CARBON_DB</name>
            <description>The datasource used for registry and user manager</description>
            <jndiConfig>
                <name>jdbc/WSO2CarbonDB</name>
            </jndiConfig>
            <definition type="RDBMS">
                <configuration>
                    <url>jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000</url>
                    <username>wso2carbon</username>
                    <password>wso2carbon</password>
                    <driverClassName>org.h2.Driver</driverClassName>
                    <maxActive>50</maxActive>
                    <maxWait>60000</maxWait>
                    <testOnBorrow>true</testOnBorrow>
                    <validationQuery>SELECT 1</validationQuery>
                    <validationInterval>30000</validationInterval>
                    <defaultAutoCommit>false</defaultAutoCommit>
                </configuration>
            </definition>
        </datasource>

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
