# OntopSpark performance evaluation

## Setup

Start the docker containers
```
sudo docker-compose -f docker-compose-hive.yml up

sudo docker-compose -f docker-compose-spark.yml up
```

Load the data into HDFS
```
sudo docker exec -it namenode /bin/bash

hadoop fs -copyFromLocal dataset /

hadoop fs -ls /dataset
```

Load the tables definition into Spark
```
sudo docker exec -it thriftserver /bin/bash

/spark/bin/spark-sql -f /tables.sql
```

Start OntopSpark
```
sudo docker-compose -f docker-compose-ontop.yml up
```

You can now run the queries located in `/datalake/queries`

# Performance evaluation


TODO: fix OntopSpark version before running tests
