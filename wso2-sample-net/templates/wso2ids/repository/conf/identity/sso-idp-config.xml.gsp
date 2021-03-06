<!--
~ Copyright (c) 2010, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

<!-- The full ServiceProvider configuration is as follows. -->

  <!--ServiceProvider>
    <Issuer></Issuer>
    <AssertionConsumerServiceURLs>
      <AssertionConsumerServiceURL></AssertionConsumerServiceURL>
    </AssertionConsumerServiceURLs>
    <DefaultAssertionConsumerServiceURL></DefaultAssertionConsumerServiceURL>
    <EnableSingleLogout>true</EnableSingleLogout>
    <SLOResponseURL></SLOResponseURL>
    <SLORequestURL></SLORequestURL>
    <SAMLDefaultSigningAlgorithmURI>http://www.w3.org/2000/09/xmldsig#rsa-sha1</SAMLDefaultSigningAlgorithmURI>
    <SAMLDefaultDigestAlgorithmURI>http://www.w3.org/2000/09/xmldsig#sha1</SAMLDefaultDigestAlgorithmURI>
    <SignResponse>true</SignResponse>
    <ValidateSignatures>true</ValidateSignatures>
    <EncryptAssertion>true</EncryptAssertion>
    <CertAlias></CertAlias>
    <EnableAttributeProfile>true</EnableAttributeProfile>
    <IncludeAttributeByDefault>true</IncludeAttributeByDefault>
    <ConsumingServiceIndex></ConsumingServiceIndex>
    <EnableAudienceRestriction>false</EnableAudienceRestriction>
    <AudiencesList>
      <Audience></Audience>
    </AudiencesList>
    <EnableRecipients>false</EnableRecipients>
    <RecipientList>
      <Recipient></Recipient>
    </RecipientList>
    <EnableIdPInitiatedSSO>false</EnableIdPInitiatedSSO>
    <EnableIdPInitSLO>false</EnableIdPInitSLO>
    <ReturnToURLList>
      <ReturnToURL></ReturnToURL>
    </ReturnToURLList>
  </ServiceProvider-->

<SSOIdentityProviderConfig>
  <ServiceProviders>
    <ServiceProvider>
 <Issuer>wso2.my.dashboard</Issuer>
 <AssertionConsumerServiceURLs>
 <AssertionConsumerServiceURL>${carbon.protocol}://${carbon.host}:${carbon.management.port}/dashboard/acs</AssertionConsumerServiceURL>
 </AssertionConsumerServiceURLs>
 <DefaultAssertionConsumerServiceURL>${carbon.protocol}://${carbon.host}:${carbon.management.port}/dashboard/acs</DefaultAssertionConsumerServiceURL>
 <SignResponse>true</SignResponse>
      <EnableAudienceRestriction>true</EnableAudienceRestriction>
      <AudiencesList>
        <Audience><%= sso_authentication.service_provider_id %></Audience>
      </AudiencesList>
    </ServiceProvider>

    <!--let's register one service provider for all carbon servers-->
    <ServiceProvider>
        <Issuer><%= sso_authentication.service_provider_id %></Issuer>
        <AssertionConsumerServiceURLs>
            <% roles.each{srv_key, srv-> %>
            <AssertionConsumerServiceURL>https://<%=srv.host%>:<%=srv.port.mhttps ?: srv.port.https%>/acs</AssertionConsumerServiceURL>
            <% if(srv_key=='idx'){ %><AssertionConsumerServiceURL>https://<%=srv.host%>:<%=srv.port.mhttps ?: srv.port.https%>/portal/acs</AssertionConsumerServiceURL><!--id-analytics portal--><% } %>
            <% } %>
        </AssertionConsumerServiceURLs>
        <!--DefaultAssertionConsumerServiceURL>${carbon.protocol}://${carbon.host}:${carbon.management.port}/acs</DefaultAssertionConsumerServiceURL-->
        <SignResponse>true</SignResponse>
        <EnableAudienceRestriction>true</EnableAudienceRestriction>
        <AudiencesList>
            <Audience><%= sso_authentication.service_provider_id %></Audience>
        </AudiencesList>
    </ServiceProvider>

    <% sso_service_providers.each{ server_name, server-> %>
    <ServiceProvider>
          <Issuer><%= server_name %></Issuer>
          <AssertionConsumerServiceURLs>
              <AssertionConsumerServiceURL><%= server['assertion_consumer_service_url'] %></AssertionConsumerServiceURL>
          </AssertionConsumerServiceURLs>
          <DefaultAssertionConsumerServiceURL><%= server['default_assertion_consumer_service_url'] %></DefaultAssertionConsumerServiceURL>
          <EnableSingleLogout>true</EnableSingleLogout>
          <SLOResponseURL/>
          <SLORequestURL/>
          <SAMLDefaultSigningAlgorithmURI>http://www.w3.org/2000/09/xmldsig#rsa-sha1</SAMLDefaultSigningAlgorithmURI>
          <SAMLDefaultDigestAlgorithmURI>http://www.w3.org/2000/09/xmldsig#sha1</SAMLDefaultDigestAlgorithmURI>
          <SignResponse>true</SignResponse>
          <ValidateSignatures>true</ValidateSignatures>
          <EncryptAssertion>false</EncryptAssertion>
          <CertAlias/>
          <EnableAttributeProfile>true</EnableAttributeProfile>
          <IncludeAttributeByDefault>true</IncludeAttributeByDefault>
          <ConsumingServiceIndex/>
          <EnableAudienceRestriction>false</EnableAudienceRestriction>
          <AudiencesList>
              <Audience/>
          </AudiencesList>
          <EnableRecipients>false</EnableRecipients>
          <RecipientList>
              <Recipient/>
          </RecipientList>
          <EnableIdPInitiatedSSO>false</EnableIdPInitiatedSSO>
          <EnableIdPInitSLO>false</EnableIdPInitSLO>
          <ReturnToURLList>
              <ReturnToURL/>
          </ReturnToURLList>
    </ServiceProvider>
    <% } %>


  </ServiceProviders>
</SSOIdentityProviderConfig>
