# OntopSpark performance evaluation

This is a testing environment for the estimation of the query execution times of OntopSpark using a Jupyter notebook.

To run the estimation, just follow the Setup and load the `OntopSpark-evaluation.ipynb` notebook in Jupyter. The average query execution times are automatically recorded by the `timeit` python library and showed in the notebook outputs.

## Setup

1. Start Hive

  ```
  sudo docker-compose -f docker-compose-hive.yml up -d
  ```

2. Wait Hive initialization (a couple of minutes), then start Apache Spark

  ```
  sudo docker-compose -f docker-compose-spark.yml up -d
  ```

3. Load the data into HDFS

  ```
  sudo docker exec -it namenode /bin/bash

  hadoop fs -copyFromLocal dataset /

  hadoop fs -ls /dataset
  ```

4. Load the tables definition into Spark

  ```
  sudo docker exec -it thriftserver /bin/bash

  /spark/bin/spark-sql -f /tables.sql
  ```

5. Start OntopSpark
  ```
  sudo docker-compose -f docker-compose-ontop.yml up -d
  ```

6. Start Jupyter notebook

  ```
  sudo docker-compose -f docker-compose-jupyter.yml up
  ```
  It is possible to access the Jupyter web interface using the links printed out from the terminal, which have the  access token already integrated. For example, if you have this terminal output:

  ```
  jupyter    |     To access the notebook, open this file in a browser:
  jupyter    |         file:///home/jovyan/.local/share/jupyter/runtime/nbserver-6-open.html
  jupyter    |     Or copy and paste one of these URLs:
  jupyter    |         http://jupyter:8888/?token=8d16d76366b3e11448795a4521fd38ab6b17afbb3d91787a
  jupyter    |      or http://127.0.0.1:8888/?token=8d16d76366b3e11448795a4521fd38ab6b17afbb3d91787a
  ```

  You can copypaste the last link (ex:`http://127.0.0.1:8888/?token=8d16d76366b3e11448795a4521fd38ab6b17afbb3d91787a`) on  your browser to access the jupyter notebook web UI (`127.0.0.1` means `localhost`).

  You can now upload the `OntopSpark-evaluation.ipynb` notebook using the WebUI and run the performace tests.
