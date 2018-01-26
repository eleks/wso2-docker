<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans   http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="processEngineConfiguration" class="org.activiti.engine.impl.cfg.StandaloneProcessEngineConfiguration">

        <property name="dataSourceJndiName" value="jdbc/ActivitiDB"/>

        <property name="databaseSchemaUpdate" value="true"/>

        <property name="jobExecutorActivate" value="true"/>

        <property name="mailServerHost" value="mail.my-corp.com"/>
        <property name="mailServerPort" value="5025"/>
        <% if( new Boolean(activiti.async) ) { %>
        <property name="asyncExecutorActivate" value="true" />
        <property name="asyncExecutorEnabled" value="true" />
        <property name="asyncExecutorCorePoolSize" value="10" />
        <property name="asyncExecutorMaxPoolSize" value="50" />
        <property name="asyncExecutorThreadPoolQueueSize" value="200" />
        <property name="asyncExecutorThreadKeepAliveTime" value="1234" />
        <% } %>

    </bean>

    <bean id="bpmnDataPublisherConfiguration">
        <property name="dataPublishingEnabled" value="false"/>
    </bean>

    <bean id="restClientConfiguration">
        <property name="maxTotalConnections" value="200"/>
        <property name="maxConnectionsPerRoute" value="200"/>
    </bean>

    <bean id="activitiInstanceDeleteConfig">
        <property name="maxCount" value="1000"/>
    </bean>


</beans>
