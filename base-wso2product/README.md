## The base simple Dockerfile for wso2 products

This dockerfile must not provide any modificators for wso2 products.
So as a result you get plain wso2 product on linux with oracle java in box.

##  build with `docker-compose`

create `docker-compose-my.yaml` file with all products you need and run

```
docker-comppose -f docker-compose-my.yaml build
```

## docker build

use the following command to build image:

```
docker build -t eleks/base-PRODNAME --build-arg WSO2_PRODUCT=PRODNAME --build-arg ENTRYPOINT=wso2server.sh .
```

## publish built images

```
docker push eleks/base-PRODNAME
```

where 

`PRODNAME:`
-	wso2bps-ver
-	wso2is-ver
-	wso2is-analytics-ver
-	...

`ENTRYPOINT:` by default entrypoint for wso2 products is `wso2server.sh` but in enterprise integrator there are several entry points:
- analytics.sh
- broker.sh
- business-process.sh
- integrator.sh


## Commands to build different wso2 products

### common steps

- download `PRODUCT_NAME.zip` and put it info files directory
- run the following commands to build and publish docker image

### wso2bps-3.5.1

```
docker build -t eleks/base-wso2bps-3.5.1 --build-arg WSO2_PRODUCT=wso2bps-3.5.1 --build-arg PORTS="9443 9999" .
docker push eleks/base-wso2bps-3.5.1
```
### wso2is-3.5.1

```
docker build -t eleks/base-wso2is-5.3.0 --build-arg WSO2_PRODUCT=wso2is-5.3.0 --build-arg PORTS="9443" .
docker push eleks/base-wso2is-5.3.0
```

### wso2ei-6.1.1

```
docker build -t eleks/base-wso2ei-6.1.1 --build-arg WSO2_PRODUCT=wso2ei-6.1.1 --build-arg ENTRYPOINT=integrator.sh .
docker push eleks/base-wso2ei-6.1.1
```


> Note: `wso2ei` product has several entry points and in this build `integrator.sh` is used. In builds depends on this image you can redefine entrypoint by using argument `ENTRYPOINT`