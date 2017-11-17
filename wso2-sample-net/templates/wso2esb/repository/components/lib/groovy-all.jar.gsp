<%
/*' let's just copy groovy all jar into esb because in this product it is absent but it's required for registry deployer */
out << new File("${env.GROOVY_HOME}/embeddable/groovy-all-${env.GROOVY_VERSION}.jar").newInputStream();
%>