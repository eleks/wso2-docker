<?xml version="1.0" encoding="ISO-8859-1"?>

<!--
  ~ Copyright 2005-2011 WSO2, Inc. (http://wso2.com)
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  -->
<wso2registry>

    <!--
    For details on configuring different config & governance registries see;
    http://wso2.org/library/tutorials/2010/04/sharing-registry-space-across-multiple-product-instances
    -->

    <currentDBConfig>wso2registry</currentDBConfig>
    <readOnly>false</readOnly>
    <enableCache>true</enableCache>
    <registryRoot>/</registryRoot>

    <dbConfig name="wso2registry">
        <dataSource><%= master_datasources[registry.local_datasource]['jndi_config'] %></dataSource>
    </dbConfig>
    
<% registry.mounts.each{ registry_mount-> %>
    <dbConfig name="<%= registry_mount.datasource %>">
        <dataSource><%= master_datasources[registry_mount.datasource]['jndi_config'] %></dataSource>
    </dbConfig>
    <remoteInstance url="https://localhost:9443/registry">
        <id><%= registry_mount.datasource %></id>
        <dbConfig><%= registry_mount.datasource %></dbConfig>
        <readOnly><%= registry_mount['read_only'] %></readOnly>
        <registryRoot><%= registry_mount['registry_root'] %></registryRoot>
        <enableCache><%= registry_mount['enable_cache'] %></enableCache>
        <cacheId><%= master_datasources[registry_mount.datasource].configuration.username %>@<%= master_datasources[registry_mount.datasource].configuration.url %></cacheId>
    </remoteInstance>
    <mount path="<%= registry_mount['path'] %>" overwrite="virtual">
        <instanceId><%= registry_mount.datasource %></instanceId>
        <targetPath><%= registry_mount['target_path'] %></targetPath>
    </mount>
<% } %>
    <indexingConfiguration>
        <startIndexing>true</startIndexing>
        <startingDelayInSeconds>35</startingDelayInSeconds>
        <indexingFrequencyInSeconds>3</indexingFrequencyInSeconds>
        <!--number of resources submit for given indexing thread -->
        <batchSize>50</batchSize>
         <!--number of worker threads for indexing -->
        <indexerPoolSize>50</indexerPoolSize>
        <!-- location storing the time the indexing took place-->
        <lastAccessTimeLocation>/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime</lastAccessTimeLocation>
        <!-- the indexers that implement the indexer interface for a relevant media type/(s) -->
        <indexers>
            <indexer class="org.wso2.carbon.registry.indexing.indexer.MSExcelIndexer" mediaTypeRegEx="application/vnd.ms-excel"/>
            <indexer class="org.wso2.carbon.registry.indexing.indexer.MSPowerpointIndexer" mediaTypeRegEx="application/vnd.ms-powerpoint"/>
            <indexer class="org.wso2.carbon.registry.indexing.indexer.MSWordIndexer" mediaTypeRegEx="application/msword"/>
            <indexer class="org.wso2.carbon.registry.indexing.indexer.PDFIndexer" mediaTypeRegEx="application/pdf"/>
            <indexer class="org.wso2.carbon.registry.indexing.indexer.XMLIndexer" mediaTypeRegEx="application/xml"/>
            <indexer class="org.wso2.carbon.registry.indexing.indexer.XMLIndexer" mediaTypeRegEx="application/(.)+\+xml"/>
            <indexer class="org.wso2.carbon.registry.indexing.indexer.PlainTextIndexer" mediaTypeRegEx="application/swagger\+json"/>
            <indexer class="org.wso2.carbon.registry.indexing.indexer.PlainTextIndexer" mediaTypeRegEx="application/(.)+\+json"/>
            <indexer class="org.wso2.carbon.registry.indexing.indexer.PlainTextIndexer" mediaTypeRegEx="text/(.)+"/>
            <indexer class="org.wso2.carbon.registry.indexing.indexer.PlainTextIndexer" mediaTypeRegEx="application/x-javascript"/>
        </indexers>
        <exclusions>
            <exclusion pathRegEx="/_system/config/repository/dashboards/gadgets/swfobject1-5/.*[.]html"/>
            <exclusion pathRegEx="/_system/local/repository/components/org[.]wso2[.]carbon[.]registry/mount/.*"/>
        </exclusions>
    </indexingConfiguration>

   <!--<handler class="org.wso2.carbon.registry.extensions.handlers.SynapseRepositoryHandler">
        <filter class="org.wso2.carbon.registry.core.jdbc.handlers.filters.MediaTypeMatcher">
            <property name="mediaType">application/vnd.apache.synapse</property>
        </filter>
    </handler>

    <handler class="org.wso2.carbon.registry.extensions.handlers.SynapseRepositoryHandler">
        <filter class="org.wso2.carbon.registry.core.jdbc.handlers.filters.MediaTypeMatcher">
            <property name="mediaType">application/vnd.apache.esb</property>
        </filter>
    </handler>

    <handler class="org.wso2.carbon.registry.extensions.handlers.Axis2RepositoryHandler">
        <filter class="org.wso2.carbon.registry.core.jdbc.handlers.filters.MediaTypeMatcher">
            <property name="mediaType">application/vnd.apache.axis2</property>
        </filter>
    </handler>

    <handler class="org.wso2.carbon.registry.extensions.handlers.Axis2RepositoryHandler">
        <filter class="org.wso2.carbon.registry.core.jdbc.handlers.filters.MediaTypeMatcher">
            <property name="mediaType">application/vnd.apache.wsas</property>
        </filter>
    </handler>

    <handler class="org.wso2.carbon.registry.extensions.handlers.WSDLMediaTypeHandler">
        <filter class="org.wso2.carbon.registry.core.jdbc.handlers.filters.MediaTypeMatcher">
            <property name="mediaType">application/wsdl+xml</property>
        </filter>
    </handler>

    <handler class="org.wso2.carbon.registry.extensions.handlers.XSDMediaTypeHandler">
        <filter class="org.wso2.carbon.registry.core.jdbc.handlers.filters.MediaTypeMatcher">
            <property name="mediaType">application/x-xsd+xml</property>
        </filter>
    </handler> -->

    <!--remoteInstance url="https://localhost:9443/registry">
        <id>instanceid</id>
        <username>username</username>
        <password>password</password>
    </remoteInstance-->

    <!--remoteInstance url="https://localhost:9443/registry">
        <id>instanceid</id>
        <dbConfig>wso2registry</dbConfig>
        <readOnly>false</readOnly>
        <enableCache>true</enableCache>
        <registryRoot>/</registryRoot>
    </remoteInstance-->

    <!--mount path="/_system/config" overwrite="true|false|virtual">
        <instanceId>instanceid</instanceId>
        <targetPath>/_system/nodes</targetPath>
    </mount-->

    
    <versionResourcesOnChange>false</versionResourcesOnChange>

    <!-- NOTE: You can edit the options under "StaticConfiguration" only before the
     startup. -->
    <staticConfiguration>
        <versioningProperties><%= registry.versioning %></versioningProperties>
        <versioningComments><%= registry.versioning %></versioningComments>
        <versioningTags><%= registry.versioning %></versioningTags>
        <versioningRatings><%= registry.versioning %></versioningRatings>
    </staticConfiguration>
</wso2registry>