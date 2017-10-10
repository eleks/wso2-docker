<datasources-configuration>

    <providers>
        <provider>org.wso2.carbon.ndatasource.rdbms.RDBMSDataSourceReader</provider>
        <!--<provider>org.wso2.carbon.datasource.reader.hadoop.HBaseDataSourceReader</provider>-->
        <!--<provider>org.wso2.carbon.datasource.reader.cassandra.CassandraDataSourceReader</provider>-->
    </providers>

    <datasources>

<% analytics_datasources.each{dsn, ds-> context.render("/datasource.gspx/RDBMS.gspx", [out:out, dsn:dsn, ds:ds]) } %>

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

