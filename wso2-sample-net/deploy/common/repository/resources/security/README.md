## goal

- generate wso2carbon.jks JKS keystore for `*.docker.local`
- create CA keypair with custom authority
- sign the certificate in keystore with CA certificate
- import public CA certificate into truststore

## tool

all above teoretically possible to do with keytool + openssl tools
but for simplicity I used http://keystore-explorer.org/

## steps

#### generate CA keystore with key-pair
![generate CA keystore with key-pair](./readme-img/01-gen-ca.png)

#### generate wso2carbon.jks with name and alternate names we need
- `*.docker.local` for out subnet names
- `192.168.99.100` as default ip for default local docker machine
- `localhost` for localhost access

![generate wso2carbon.jks with name and alternate names we need](./readme-img/02-gen-wso2carbon.jks.png)

#### generate request for signature 
![generate request for signature](./readme-img/03-sign-req.png)

#### sign the request with CA certificate
![sign the request with CA certificate](./readme-img/04-sign.png)

#### import the signature reply into wso2carbon.jks
![import the signature reply into wso2carbon.jks](./readme-img/05-imp-sign-repl.png)

#### wso2carbon.jks result
![wso2carbon.jks result](./readme-img/06-result.png)

#### export public CA certificate
![export public CA certificate](./readme-img/07-ca-exp-01.png)

#### export public CA certificate - 2
![export public CA certificate - 2](./readme-img/07-ca-exp-02.png)

#### import public CA certificate into truststore
![import public CA certificate into truststore](./readme-img/08-ca-imp-trust.png)

