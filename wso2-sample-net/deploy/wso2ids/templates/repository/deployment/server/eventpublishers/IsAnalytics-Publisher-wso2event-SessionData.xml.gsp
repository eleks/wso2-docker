<?xml version="1.0" encoding="UTF-8"?>
<eventPublisher name="IsAnalytics-Publisher-wso2event-SessionData" statistics="disable" trace="disable" xmlns="http://wso2.org/carbon/eventpublisher">
  <from streamName="org.wso2.is.analytics.stream.OverallSession" version="1.0.0"/>
  <mapping customMapping="disable" type="wso2event"/>
  <to eventAdapterType="wso2event">
    <property name="username"><%= identity_analytics['username'] %></property>
    <property name="protocol">thrift</property>
    <property name="publishingMode">non-blocking</property>
    <property name="publishTimeout">0</property>
    <property name="receiverURL"><%= identity_analytics['receiverURL'] %></property>
    <property encrypted="false" name="password"><%= identity_analytics['password'] %></property>
  </to>
</eventPublisher>
