docker build -t eleks/PRODNAME --build-arg WSO2_PRODUCT=PRODNAME .
docker push eleks/PRODNAME

where PRODNAME:
	wso2is
	wso2is-analytics
	...

