# ------------------------------------------------------
# CARBON RELATED SPARK PROPERTIES
# ------------------------------------------------------
# Carbon specific properties when running Spark in the Carbon environment.
# Should start with the prefix "carbon."

# carbon.spark.master config has 3 states
#   1. (default) local mode - spark starts in the local mode (NOTE: carbon.spark.master.count property
#       will not be considered here)
#       ex: "carbon.spark.master local" or "carbon.spark.master local[2]"
#   2. client mode - DAS acts as a client for an external Spark cluster (NOTE: carbon.spark.master.count property
#       will not be considered here)
#       ex: "carbon.spark.master spark://<host name>:<port>"
#   3. cluster mode - DAS creates its own Spark cluster usign Carbon Clustering
#       ex: "carbon.spark.master local" AND "carbon.spark.master.count  <number of redundant masters>"

carbon.spark.master local
carbon.spark.master.count  1

#This configuration is used to limit the number of results returned from spark query execution
#To return all the results, set this to -1
carbon.spark.results.limit 1000

# Below configuratoin can be used to point to a symbolic link to WSO2 DAS HOME
# carbon.das.symbolic.link /home/ubuntu/das/das_symlink/

# Below configuration can be used with the spark fair scheduler, when fair schedule pools are used. the
#     defualt pool name for carbon is 'carbon-pool'
# carbon.scheduler.pool carbon-pool



# ------------------------------------------------------
# SPARK PROPERTIES
# ------------------------------------------------------
# Default system properties included when running spark.
# This is useful for setting default environmental settings.
# Check http://spark.apache.org/docs/latest/configuration.html for further information

# Application (Spark Driver) Properties
# ------------------------------------------------------
spark.app.name  CarbonAnalytics
# Spark Driver will be running inside the carbon JVM. Hence the below properties are obsolete
# spark.driver.cores 1
# spark.driver.memory 512m

# Runtime Environment
# ------------------------------------------------------

# Spark UI
spark.ui.port 4040
spark.history.ui.port 18080

# Compression and Serialization
spark.serializer  org.apache.spark.serializer.KryoSerializer
spark.kryoserializer.buffer 256k
spark.kryoserializer.buffer.max 256m

# Execution Behavior

# Networking
spark.blockManager.port 12000
spark.broadcast.port  12500
spark.driver.port 13000
spark.executor.port 13500
spark.fileserver.port 14000
spark.replClassServer.port 14500
spark.akka.timeout	1000s

# Scheduling
spark.scheduler.mode FAIR
# this property can be set to specify where hte fairscheduler.xml file is. the carbon specific
#     fairscheduler.xml is in the <DAS_HOME>/repository/conf/analytics/spark directory
# spark.scheduler.allocation.file <DAS_HOME>/repository/conf/analytics/spark/fairscheduler.xml

# Dynamic Allocation

# Security

# Encryption

# Standalone Cluster Configs
spark.deploy.recoveryMode CUSTOM
spark.deploy.recoveryMode.factory org.wso2.carbon.analytics.spark.core.deploy.AnalyticsRecoveryModeFactory

# Master
spark.master.port 7077
spark.master.rest.port 6066
spark.master.webui.port 8081

# Worker
spark.worker.cores 1
spark.worker.memory 1g
spark.worker.dir work
spark.worker.port 11000
spark.worker.webui.port 11500

# Executors
# spark.executor.cores 1 ; Default: Takes all the available cores in the worker
spark.executor.memory 1g
spark.executor.logs.rolling.strategy  size
spark.executor.logs.rolling.maxSize  10000000
spark.executor.logs.rolling.maxRetainedFiles 10

# spark.cores.max ; Default: Int.MAX_VALUE; The maximum amount of CPU cores to request for the application from across
# the cluster (not from each machine)


# Spark Logging
# ------------------------------------------------------
# To allow event logging for spark you need to uncomment
# the line spark.eventlog.log true and set the directory in which the
# logs will be stored.

# spark.eventLog.enabled true
# spark.eventLog.dir <PATH_FOR_SPARK_EVENT_LOGS>

# YARN related configs
# ------------------------------------------------------
# spark.yarn.jar <path to the spark-core_2.10_1.4.3.wso2v1.jar>


