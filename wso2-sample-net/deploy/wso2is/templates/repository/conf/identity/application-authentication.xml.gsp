<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
~ Copyright (c) 2014, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

<ApplicationAuthentication xmlns="http://wso2.org/projects/carbon/application-authentication.xml">

	<!--
		ProxyMode allows framework to operate in either 'smart' mode 
		or 'dumb' mode.
		smart = both local and federated authentication is supported
		dumb = only federated authentication is supported
	-->
	<ProxyMode>smart</ProxyMode>	
	 
	<!-- 
		AuthenticationEndpointURL is location of the web app containing 
		the authentication related pages 
	--> 
	<AuthenticationEndpointURL>/authenticationendpoint/login.do</AuthenticationEndpointURL>
	<AuthenticationEndpointRetryURL>/authenticationendpoint/retry.do</AuthenticationEndpointRetryURL>
	
	<!--
		Extensions allow extending the default behaviour of the authentication
		process. 	
	-->
	<Extensions> 
		<RequestCoordinator>org.wso2.carbon.identity.application.authentication.framework.handler.request.impl.DefaultRequestCoordinator</RequestCoordinator>
		<AuthenticationRequestHandler>org.wso2.carbon.identity.application.authentication.framework.handler.request.impl.DefaultAuthenticationRequestHandler</AuthenticationRequestHandler>
		<LogoutRequestHandler>org.wso2.carbon.identity.application.authentication.framework.handler.request.impl.DefaultLogoutRequestHandler</LogoutRequestHandler>
		<StepBasedSequenceHandler>org.wso2.carbon.identity.application.authentication.framework.handler.sequence.impl.DefaultStepBasedSequenceHandler</StepBasedSequenceHandler>
		<RequestPathBasedSequenceHandler>org.wso2.carbon.identity.application.authentication.framework.handler.sequence.impl.DefaultRequestPathBasedSequenceHandler</RequestPathBasedSequenceHandler>
		<StepHandler>org.wso2.carbon.identity.application.authentication.framework.handler.step.impl.DefaultStepHandler</StepHandler>
		<HomeRealmDiscoverer>org.wso2.carbon.identity.application.authentication.framework.handler.hrd.impl.DefaultHomeRealmDiscoverer</HomeRealmDiscoverer>
		<ClaimHandler>org.wso2.carbon.identity.application.authentication.framework.handler.claims.impl.DefaultClaimHandler</ClaimHandler>
		<ProvisioningHandler>org.wso2.carbon.identity.application.authentication.framework.handler.provisioning.impl.DefaultProvisioningHandler</ProvisioningHandler>
		<AuthorizationHandler>org.wso2.carbon.identity.application.authz.xacml.handler.impl.XACMLBasedAuthorizationHandler</AuthorizationHandler>
	</Extensions>

	<!--
		AuthenticatorNameMappings allow specifying an authenticator
		against a pre-defined alias (which will be used by other components. 
		E.g. Application Mgt component). This enables the usage of a custom 
		authenticator in place of an authenticator that gets packed with the 
		distribution.	
	-->
    <AuthenticatorNameMappings>
        <AuthenticatorNameMapping name="BasicAuthenticator" alias="basic" />
        <AuthenticatorNameMapping name="OAuthRequestPathAuthenticator" alias="oauth-bearer" />
        <AuthenticatorNameMapping name="BasicAuthRequestPathAuthenticator" alias="basic-auth" />
        <AuthenticatorNameMapping name="IWAAuthenticator" alias="iwa" />
        <AuthenticatorNameMapping name="SAMLSSOAuthenticator" alias="samlsso" />
        <AuthenticatorNameMapping name="OpenIDConnectAuthenticator" alias="openidconnect" />
        <AuthenticatorNameMapping name="OpenIDAuthenticator" alias="openid" />
        <AuthenticatorNameMapping name="PassiveSTSAuthenticator" alias="passive-sts" />
    </AuthenticatorNameMappings>

    <!-- 
		AuthenticatorConfigs allow specifying various configurations needed 
		by the authenticators by using any number of \'Parameter\' elements  
		E.g.
		<AuthenticatorConfig name="CustomAuthenticator" enabled="true" />
			<Parameter name="paramName1">paramValue</Parameter>
			<Parameter name="paramName2">paramValue</Parameter>
		</AuthenticatorConfig>
    -->
	<AuthenticatorConfigs>
		<AuthenticatorConfig name="BasicAuthenticator" enabled="true">
			<!--Parameter name="UserNameAttributeClaimUri">http://wso2.org/claims/emailaddress</Parameter-->
			<!--Parameter name="showAuthFailureReason">true</Parameter-->	
		</AuthenticatorConfig>
		<AuthenticatorConfig name="OAuthRequestPathAuthenticator" enabled="true" />
		<AuthenticatorConfig name="BasicAuthRequestPathAuthenticator" enabled="true" />
 		<AuthenticatorConfig name="SAMLSSOAuthenticator" enabled="true">
			<!--Parameter name="SignAuth2SAMLUsingSuperTenant">true</Parameter-->
			<!--Parameter name="SAML2SSOManager">org.wso2.carbon.identity.application.authenticator.samlsso.manager.DefaultSAML2SSOManager</Parameter-->
		</AuthenticatorConfig>
		<AuthenticatorConfig name="OpenIDConnectAuthenticator" enabled="true">
			<!--Parameter name="IDTokenHandler">org.wso2.carbon.identity.application.authenticator.oidc.DefaultIDTokenHandler</Parameter-->
			<!--Parameter name="ClaimsRetriever">org.wso2.carbon.identity.application.authenticator.oidc.OIDCUserInfoClaimsRetriever</Parameter-->	
		</AuthenticatorConfig>
		<AuthenticatorConfig name="OpenIDAuthenticator" enabled="true">
			<Parameter name="LoginPage">/authenticationendpoint/login.do</Parameter>
			<Parameter name="TrustStorePath">/<%= key_stores['trust_store']['location'] %></Parameter>
			<Parameter name="TrustStorePassword"><%= key_stores['trust_store']['password'] %></Parameter>
			<!--Parameter name="OpenIDManager">org.wso2.carbon.identity.application.authenticator.openid.manager.DefaultOpenIDManager</Parameter>
			<Parameter name="AttributesRequestor">org.wso2.carbon.identity.application.authenticator.openid.manager.SampleAttributesRequestor</Parameter-->
		</AuthenticatorConfig>
		<AuthenticatorConfig name="GoogleOIDCAuthenticator" enabled="true">
			<Parameter name="GoogleTokenEndpoint">https://accounts.google.com/o/oauth2/token</Parameter>
			<Parameter name="GoogleAuthzEndpoint">https://accounts.google.com/o/oauth2/auth</Parameter>
			<Parameter name="GoogleUserInfoEndpoint">https://www.googleapis.com/oauth2/v3/userinfo</Parameter>
		</AuthenticatorConfig>
		<AuthenticatorConfig name="MicrosoftWindowsLive" enabled="true">
			<Parameter name="AuthTokenEndpoint">https://login.live.com/oauth20_token.srf</Parameter>
			<Parameter name="AuthnEndpoint">https://login.live.com/oauth20_authorize.srf</Parameter>
			<Parameter name="UserInfoEndpoint">https://apis.live.net/v5.0/me?access_token=</Parameter>
		</AuthenticatorConfig>
		<AuthenticatorConfig name="FacebookAuthenticator" enabled="true">
			<Parameter name="AuthTokenEndpoint">https://graph.facebook.com/oauth/access_token</Parameter>
			<Parameter name="AuthnEndpoint">http://www.facebook.com/dialog/oauth</Parameter>
			<Parameter name="UserInfoEndpoint">https://graph.facebook.com/me</Parameter>
		</AuthenticatorConfig>
		<AuthenticatorConfig  name="FIDOAuthenticator" enabled="true">
			<Parameter name="FidoAuth">/authenticationendpoint/fido-auth.jsp</Parameter>
		</AuthenticatorConfig>
		<AuthenticatorConfig name="YahooOAuth2Authenticator" enabled="true">
			<Parameter name="YahooTokenEndpoint">https://api.login.yahoo.com/oauth2/get_token</Parameter>
			<Parameter name="YahooOAuthzEndpoint">https://api.login.yahoo.com/oauth2/request_auth</Parameter>
			<Parameter name="YahooUserInfoEndpoint">https://social.yahooapis.com/v1/user/</Parameter>
		</AuthenticatorConfig>
		<AuthenticatorConfig name="MobileConnectAuthenticator" enabled="true">
			<Parameter name="MobileConnectKey">mobileConnectClientId</Parameter>
			<Parameter name="MobileConnectSecret">mobileConnectClientSecret</Parameter>
		</AuthenticatorConfig>
        <AuthenticatorConfig name="EmailOTP" enabled="true">
            <Parameter name="GmailClientId">gmailClientIdValue</Parameter>
            <Parameter name="GmailClientSecret">gmailClientSecretValue</Parameter>
            <Parameter name="SendgridAPIKey">sendgridAPIKeyValue</Parameter>
            <Parameter name="GmailRefreshToken">gmailRefreshTokenValue</Parameter>
            <Parameter name="GmailEmailEndpoint">https://www.googleapis.com/gmail/v1/users/[userId]/messages/send</Parameter>
            <Parameter name="SendgridEmailEndpoint">https://api.sendgrid.com/api/mail.send.json</Parameter>
            <Parameter name="accessTokenRequiredAPIs">Gmail</Parameter>
            <Parameter name="apiKeyHeaderRequiredAPIs">Sendgrid</Parameter>
            <Parameter name="SendgridFormData">sendgridFormDataValue</Parameter>
            <Parameter name="SendgridURLParams">sendgridURLParamsValue</Parameter>
            <Parameter name="GmailAuthTokenType">Bearer</Parameter>
            <Parameter name="GmailTokenEndpoint">https://www.googleapis.com/oauth2/v3/token</Parameter>
            <Parameter name="SendgridAuthTokenType">Bearer</Parameter>
        </AuthenticatorConfig>
        <AuthenticatorConfig name="x509CertificateAuthenticator" enabled="true">
            <Parameter name="AuthenticationEndpoint">https://localhost:8443/x509-certificate-servlet</Parameter>
        </AuthenticatorConfig>
        <AuthenticatorConfig name="totp" enabled="true">
            <Parameter name="encodingMethod">Base32</Parameter>
            <Parameter name="timeStepSize">30</Parameter>
            <Parameter name="windowSize">3</Parameter>
            <Parameter name="enableTOTP">false</Parameter>
        </AuthenticatorConfig>
	</AuthenticatorConfigs> 

    <!--
		Sequences allow specifying authentication flows for different
		registered applications. \'default\' sequence is taken if an
		application specific sequence doesn't exist in this file or
		in the Application Mgt module.
    -->	
	<Sequences>
		<!-- Default Sequence. This is mandatory -->
		<Sequence appId="default">
			<Step order="1">
				<Authenticator name="BasicAuthenticator"/>
			</Step>
		</Sequence>
	</Sequences>
	
	<!-- 
        	AuthenticationEndpointQueryParams are the request parameters 
        	that would be sent to the AuthenticationEndpoint. 
        	'action' defines the behaviour: if 'include', only the defined 
        	parameters would be included in the request. 
        	If 'exclude' specified, all the parameters received by the 
        	Authentication Framework would be sent in the request except 
        	the ones specified. 
        	'sessionDataKey', 'type', 'relyingParty', 'sp' and 'authenticators' 
        	parameters will be always sent. They should not be specified here.  
    	-->
    	<AuthenticationEndpointQueryParams action="exclude">
        	<AuthenticationEndpointQueryParam name="username"/>
        	<AuthenticationEndpointQueryParam name="password"/>
            <AuthenticationEndpointQueryParam name="SAMLRequest"/>
        </AuthenticationEndpointQueryParams>
	
	    <!--TenantDomainDropDownEnabled>true</TenantDomainDropDownEnabled>
	    <TenantDataListenerURLs>
		  <TenantDataListenerURL>/authenticationendpoint/tenantlistrefresher.do</TenantDataListenerURL>
	    </TenantDataListenerURLs-->

</ApplicationAuthentication>
