## base image for java-based products

### goal
provide image with base linux utilities , java 8 , and groovy-based templating engine for deploying 

### commands to build and publish

`docker build -t eleks/base-ubuntu-jdk8-groovy .`

`docker push eleks/base-ubuntu-jdk8-groovy`

### how templating and configuration works

two folders declared to be externalized:
```
VOLUME  /opt/conf
VOLUME  /opt/deploy
```

#### `/opt/conf` 

folder location could be reconfigured with `CONF_SOURCE` environment variable

directory dedicated to put configuration files that could be used during templating process.

also the format of the configuration files could be `yaml` or `json`.

it's possible to use `${...}` groovy expression language in values


for example `properties` file:

```bash
my_environment=test
api.url.prefix=https://${my_environment}.company.com:8443
current.date=${new Date().format('yyyy-MM-dd')}

database.db1.url=${my_environment}.dbhost:1111
database.db1.user=${my_environment}_user1
database.db2.url=${my_environment}.dbhost:2222
database.db2.user=${my_environment}_user2
```

the result of loading this file:

```bash
my_environment=test
api.url.prefix=https://test.company.com:8443
current.date=2016-12-31

database.db1.url=test.dbhost:1111
database.db1.user=test_user1
database.db2.url=test.dbhost:2222
database.db2.user=test_user2
```

and finally it will be converted to tree-map:

```yaml
my_environment: test
api:
  url:
    prefix: https://test.company.com:8443
current:
  date: '2016-12-31'
database:
  db1:
    url: test.dbhost:1111
    user: test_user1
  db2:
    url: test.dbhost:2222
    user: test_user2
```

so in groovy the expression `current.date` will return `2016-12-31`

and `current.getClass().getName()` will return the implementation of `java.util.Map`

#### `/opt/deploy` 

folder location could be reconfigured with `DEPLOY_SOURCE` environment variable

in this folder you can put configuration templates `(*.gsp)` and other files that will be copied into `DEPLOY_TARGET` directory defined as environment variable.

#### `gcli deploy` command

if you have environment variable `DEPLOY_TARGET=/opt/myserver` 

and you have files: 
```
/opt/deploy/conf/myconf.property.gsp
/opt/deploy/lib/mylib.jar
```

then the command `gcli deploy` will copy evaluated template `myconf.property` and plain binary file `mylib.jar` into the following structure
```
/opt/myserver/conf/myconf.property
/opt/myserver/lib/mylib.jar
```

#### *.gsp template syntax

templates have JSP-like syntax with groovy as a language.

the following template with properties defined in section above

```ERB
the environment: <%= my_environment %>
databases: 
<% database.each{k,v-> %>
   name    : <%= k %>
      url  : <%= v.url %>
      user : <%= v.user %>
<% } %>
```

will result:
```
the environment: test
databases: 

   name    : db1
      url  : test.dbhost:1111
      user : test_user1

   name    : db2
      url  : test.dbhost:222
      user : test_user2
```
