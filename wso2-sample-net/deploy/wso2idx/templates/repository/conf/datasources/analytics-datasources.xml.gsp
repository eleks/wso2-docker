<datasources-configuration>

    <providers>
        <provider>org.wso2.carbon.ndatasource.rdbms.RDBMSDataSourceReader</provider>
        <!--<provider>org.wso2.carbon.datasource.reader.hadoop.HBaseDataSourceReader</provider>-->
        <!--<provider>org.wso2.carbon.datasource.reader.cassandra.CassandraDataSourceReader</provider>-->
    </providers>

    <datasources>

        <datasource>
            <name>WSO2_ANALYTICS_EVENT_STORE_DB</name>
            <description>The datasource used for analytics record store</description>
            <definition type="RDBMS">
                <configuration>
                    <url>jdbc:h2:repository/database/ANALYTICS_EVENT_STORE;AUTO_SERVER=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000</url>
                    <username>wso2carbon</username>
                    <password>wso2carbon</password>
                    <driverClassName>org.h2.Driver</driverClassName>
                    <maxActive>50</maxActive>
                    <maxWait>60000</maxWait>
                    <validationQuery>SELECT 1</validationQuery>
                    <defaultAutoCommit>false</defaultAutoCommit>
                    <initialSize>0</initialSize>
                    <testWhileIdle>true</testWhileIdle>
                    <minEvictableIdleTimeMillis>4000</minEvictableIdleTimeMillis>
                    <defaultTransactionIsolation>READ_COMMITTED</defaultTransactionIsolation>
                </configuration>
            </definition>
        </datasource>

        <datasource>
            <name>WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB</name>
            <description>The datasource used for analytics record store</description>
            <definition type="RDBMS">
                <configuration>
                    <url>jdbc:h2:repository/database/ANALYTICS_PROCESSED_DATA_STORE;AUTO_SERVER=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000</url>
                    <username>wso2carbon</username>
                    <password>wso2carbon</password>
                    <driverClassName>org.h2.Driver</driverClassName>
                    <maxActive>50</maxActive>
                    <maxWait>60000</maxWait>
                    <validationQuery>SELECT 1</validationQuery>
                    <defaultAutoCommit>false</defaultAutoCommit>
                    <initialSize>0</initialSize>
                    <testWhileIdle>true</testWhileIdle>
                    <minEvictableIdleTimeMillis>4000</minEvictableIdleTimeMillis>
                    <defaultTransactionIsolation>READ_COMMITTED</defaultTransactionIsolation>
                </configuration>
            </definition>
        </datasource>

        <!-- Sample datasource implementation for HBase Analytics RecordStore-->
        <!--<datasource>
            <name>WSO2_ANALYTICS_RS_DB_HBASE</name>
            <description>The datasource used for analytics file system</description>
            <jndiConfig>
                <name>jdbc/WSO2HBaseDB</name>
            </jndiConfig>
            <definition type="HBASE">
                <configuration>
                    <property>
                        <name>hbase.master</name>
                        <value>localhost:60000</value>
                    </property>
                    <property>
                        <name>fs.hdfs.impl</name>
                        <value>org.apache.hadoop.hdfs.DistributedFileSystem</value>
                    </property>
                    <property>
                        <name>fs.file.impl</name>
                        <value>org.apache.hadoop.fs.LocalFileSystem</value>
                    </property>
                </configuration>
            </definition>
        </datasource>-->

        <!-- Sample datasource implementation for Cassandra -->
        <!--<datasource>
            <name>WSO2_ANALYTICS_DS_CASSANDRA</name>
            <description>The Cassandra datasource used for analytics</description>
            <definition type="CASSANDRA">
                <configuration>
                    <contactPoints>localhost</contactPoints>
                    <port>9042</port>
                    <username>admin</username>
                    <password>admin</password>
                    <clusterName>cluster1</clusterName>
                    <compression>NONE</compression>
                    <poolingOptions>
                        <coreConnectionsPerHost hostDistance="LOCAL">8</coreConnectionsPerHost>
                        <maxSimultaneousRequestsPerHostThreshold hostDistance="LOCAL">1024</maxSimultaneousRequestsPerHostThreshold>
                    </poolingOptions>
                    <queryOptions>
                        <fetchSize>5000</fetchSize>
                        <consistencyLevel>ONE</consistencyLevel>
                        <serialConsistencyLevel>SERIAL</serialConsistencyLevel>
                    </queryOptions>
                    <socketOptions>
                        <keepAlive>false</keepAlive>
                        <sendBufferSize>150000</sendBufferSize>
                        <connectTimeoutMillis>12000</connectTimeoutMillis>
                        <readTimeoutMillis>12000</readTimeoutMillis>
                    </socketOptions>
                </configuration>
            </definition>
        </datasource>-->

    </datasources>

</datasources-configuration>

