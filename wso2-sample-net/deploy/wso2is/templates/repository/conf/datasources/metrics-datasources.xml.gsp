<?xml version="1.0" encoding="utf-8"?>
<!--
    # Copyright (c) 2015, WSO2 Inc. (http://www.wso2.org)
    #
    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at
    #
    # http://www.apache.org/licenses/LICENSE-2.0
    #
    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.
-->
<datasources-configuration xmlns:svns="http://org.wso2.securevault/configuration">

    <providers>
        <provider>org.wso2.carbon.ndatasource.rdbms.RDBMSDataSourceReader</provider>
    </providers>

    <datasources>
        <% metrics_datasources.each{ datasource_name, datasource-> %>
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
                    <defaultAutoCommit><%= datasource['default_auto_commit'] %></defaultAutoCommit>
                </configuration>
            </definition>
        </datasource>
        <% } %>

        <!-- MySQL -->
        <!--
        <datasource>
            <name>WSO2_METRICS_DB</name>
            <description>The MySQL datasource used for WSO2 Carbon Metrics</description>
            <jndiConfig>
                <name>jdbc/WSO2MetricsDB</name>
            </jndiConfig>
            <definition type="RDBMS">
                <configuration>
                    <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                    <url>jdbc:mysql://localhost/wso2_metrics</url>
                    <username>root</username>
                    <password>root</password>
                    <maxActive>50</maxActive>
                    <maxWait>60000</maxWait>
                    <minIdle>5</minIdle>
                    <testOnBorrow>true</testOnBorrow>
                    <validationQuery>SELECT 1</validationQuery>
                    <validationInterval>30000</validationInterval>
                    <defaultAutoCommit>true</defaultAutoCommit>
                </configuration>
            </definition>
        </datasource>
        -->

        <!-- MSSQL (JTDS Driver) -->
        <!--
        <datasource>
            <name>WSO2_METRICS_DB</name>
            <description>The MSSQL datasource used for WSO2 Carbon Metrics</description>
            <jndiConfig>
                <name>jdbc/WSO2MetricsDB</name>
            </jndiConfig>
            <definition type="RDBMS">
                <configuration>
                    <driverClassName>net.sourceforge.jtds.jdbc.Driver</driverClassName>
                    <url>jdbc:jtds:sqlserver://localhost:1433/wso2_metrics</url>
                    <username>sa</username>
                    <password>sa</password>
                    <maxActive>200</maxActive>
                    <maxWait>60000</maxWait>
                    <minIdle>5</minIdle>
                    <testOnBorrow>true</testOnBorrow>
                    <validationQuery>SELECT 1</validationQuery>
                    <validationInterval>30000</validationInterval>
                    <defaultAutoCommit>true</defaultAutoCommit>
                </configuration>
            </definition>
        </datasource>
        -->

        <!-- SQLServer XA -->
        <!--
        <datasource>
            <name>WSO2_METRICS_DB</name>
            <description>The SQLServer XA datasource used for WSO2 Carbon Metrics</description>
            <jndiConfig>
                <name>jdbc/WSO2MetricsDB</name>
            </jndiConfig>
            <definition type="RDBMS">
                <configuration>
                    <defaultAutoCommit>true</defaultAutoCommit>
                    <dataSourceClassName>com.microsoft.sqlserver.jdbc.SQLServerXADataSource</dataSourceClassName>
                    <dataSourceProps>
                        <property name="URL">jdbc:sqlserver://localhost/SQLExpress:1433</property>
                        <property name="databaseName">wso2_metrics</property>
                        <property name="user">sa</property>
                        <property name="password">sa</property>
                    </dataSourceProps>
                </configuration>
            </definition>
        </datasource>
        -->

        <!-- Oracle -->
        <!--
        <datasource>
            <name>WSO2_METRICS_DB</name>
            <description>The Oracle datasource used for WSO2 Carbon Metrics</description>
            <jndiConfig>
                <name>jdbc/WSO2MetricsDB</name>
            </jndiConfig>
            <definition type="RDBMS">
                <configuration>
                    <driverClassName>oracle.jdbc.OracleDriver</driverClassName>
                    <url>jdbc:oracle:thin:@localhost:1521/wso2_metrics</url>
                    <username>scott</username>
                    <password>tiger</password>
                    <maxActive>100</maxActive>
                    <maxWait>60000</maxWait>
                    <minIdle>5</minIdle>
                    <testOnBorrow>true</testOnBorrow>
                    <validationQuery>SELECT 1 FROM DUAL</validationQuery>
                    <validationInterval>30000</validationInterval>
                    <defaultAutoCommit>true</defaultAutoCommit>
                    <databaseProps>
                        <property name="SetFloatAndDoubleUseBinary">true</property>
                    </databaseProps>
                </configuration>
            </definition>
        </datasource>
        -->
    </datasources>

</datasources-configuration>
