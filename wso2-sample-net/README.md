## docker-compose config to run wso2 servers



### download and install "docker toolbox"

https://www.docker.com/products/docker-toolbox

### start "Docker Quickstart Terminal" link from your desktop


if there will be an option - use "virtual box" docker machine config

if all is OK you have to see:
```bash
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/
 
docker is configured to use the default machine with IP 192.168.99.100
For help getting started, check out the docs at https://docs.docker.com
 
Start interactive shell
$_
```

 
### configure docker-machine memory usage

by default the docker-machine configured to use ~2gb of memory. let's recreate machine with more memory
in the "Docker Quickstart Terminal" use the following commands:
```bash
# list docker machines - by default you should see the one - default
docker-machine ls
# remove the `default` machine
docker-machine rm default
# create
docker-machine create -d virtualbox --virtualbox-memory 5120 --virtualbox-hostonly-cidr "192.168.99.3/24" default
```
If the docker-machine has been created with the ip different then 192.168.99.100 then repeat commands above

 
### download latest artifacts

this is just an example shell script how to automate artifact download

in the docker terminal run the following command:
```bash
./get-latest-artifacts.sh
```

 
### start docker containers defined with docker-compose.yaml

clone or download git repository https://github.com/eleks/wso2-dockers
git clone https://github.com/eleks/wso2-dockers

do it somewhere under user-home directory like c:\users\USERNAME\projects\wso2-dockers because of windows restrictions

in the "Docker Quickstart Terminal" type following commands to run all servers defined in docker-compose.yaml
```bash
# go to docker-compose sample project directory
cd /c/users/USERNAME/projects/wso2-dockers/wso2-sample-net/
# start docker subnet with detached mode
docker-compose up -d
```

If you have the following error during docker containers start:

> /bin/sh: 1: /opt/wso2bps-3.5.1/bin/wso2server.sh: not found

it means that your git client did conversion of line endings

you have to turn off the `core.autocrlf` git feature
```bash
git config --global core.autocrlf false
```
 
### start "Kitematic"

The "Kitematic" - a simple, yet powerful graphical user interface

From your desktop start Kitematic

Choose option "use virtual box" when suggested.

Skip login process.

You have to see 4 servers started on your docker-machine: ids, esb, bps, idx (analytics)

 
### open server console

now you can open server web console:
 
| *   | url                                 |
|-----|-------------------------------------|
| bps |	https://192.168.99.100:9444/carbon/ |
| esb	| https://192.168.99.100:9445/carbon/ |
| identity server (ids)	| https://192.168.99.100:9446/carbon/
| identity server (ids) admin dashboard	| https://192.168.99.100:9446/dashboard/ |
| identity server analytics (idx)	| https://192.168.99.100:9447/carbon/ |
| identity server analytics (idx)	| https://192.168.99.100:9447/portal/ |

 

where `192.168.99.100` is IP address of your docker machine

 
### change ip configuration

if the ip of your docker machine is not  192.168.99.100

you can change file `.env` to modify this value

### deploy artifacts

to deploy something new on your server put it into the folder `deploy` into corresponding server subfolder

or specify another subfolder in the file `.env` where to take artifacts

### certificates

instruction how to generate a certificate and sign it with custom CA certificate

[generate keystore, truststore, and CA for our docker subnet](templates/common/repository/resources/security)
