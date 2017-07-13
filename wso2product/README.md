## docker-compose build

create `docker-compose.yaml` file with all products you need and run
```
docker-comppose build
```

## docker build

use the following command to build and publish images:

```
docker build -t eleks/PRODNAME --build-arg WSO2_PRODUCT=PRODNAME --build-arg ENTRYPOINT=wso2server.sh .
docker push eleks/PRODNAME
```

where 

`PRODNAME:`
-	wso2is
-	wso2is-analytics
-	...

`ENTRYPOINT:` by default entrypoint for wso2 products is `wso2server.sh` but in enterprise integrator there are several entry points:
- analytics.sh
- broker.sh
- business-process.sh
- integrator.sh


## Example wso2is-5.3.0:

download `wso2is-5.3.0.zip` and put it info files directory

run the following command to build it as docker image:

`docker build -t eleks/wso2is-5.3.0 --build-arg WSO2_PRODUCT=wso2is-5.3.0 .`


## Example wso2ei-6.1.1:

download `wso2ei-6.1.1.zip` and put it info files directory

run the following command to build it as docker image:

`docker build -t eleks/wso2ei-6.1.1-integrator --build-arg WSO2_PRODUCT=wso2ei-6.1.1 --build-arg ENTRYPOINT=integrator.sh .`
