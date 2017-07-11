docker build -t eleks/PRODNAME --build-arg WSO2_PRODUCT=PRODNAME .
docker push eleks/PRODNAME

where PRODNAME:
	wso2is
	wso2is-analytics
	...

Example:

download wso2is-5.3.0.zip and put it info files directory

run the following command to build it as docker image:

docker build -t eleks/wso2is-5.3.0 --build-arg WSO2_PRODUCT=wso2is-5.3.0 .
