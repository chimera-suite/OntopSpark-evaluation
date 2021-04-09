DROP DATABASE IF EXISTS testDB CASCADE;

CREATE DATABASE IF NOT EXISTS testDB;


CREATE TABLE IF NOT EXISTS testDB.producer(
           nr INT,
           label STRING,
           comment STRING,
           homepage STRING,
           country STRING,
           publisher INT,
           publishDate DATE
       )
USING csv
OPTIONS (path 'hdfs://namenode:8020/dataset/producer/producer_no_header.csv');



CREATE TABLE IF NOT EXISTS testDB.review(
           nr INT,
           product INT,
           producer INT,
           person INT,
           reviewDate DATE,
           title STRING,
           text STRING,
           language STRING,
           rating1 INT,
           rating2 INT,
           rating3 INT,
           rating4 INT,
           publisher INT,
           publishDate DATE
       )
USING csv
OPTIONS (path 'hdfs://namenode:8020/dataset/review/review_no_header.csv');



CREATE TABLE IF NOT EXISTS testDB.person(
           nr INT,
           name STRING,
           mbox_sha1sum STRING,
           country STRING,
           publisher INT,
           publishDate DATE
       )
USING csv
OPTIONS (path 'hdfs://namenode:8020/dataset/person/person_no_header.csv');



CREATE TABLE IF NOT EXISTS testDB.offer(
           _id INT,
           product INT,
           producer INT,
           vendor INT,
           price DOUBLE,
           validFrom DATE,
           validTo DATE,
           deliveryDays INT,
           offerWebpage STRING,
           publisher INT,
           publishDate DATE
       )
USING csv
OPTIONS (path 'hdfs://namenode:8020/dataset/offer/offer_no_header.csv');



CREATE TABLE IF NOT EXISTS testDB.product(
           nr INT,
           label STRING,
           comment STRING,
           producer INT,
           propertyNum1 INT,
           propertyNum2 INT,
           propertyNum3 INT,
           propertyNum4 INT,
           propertyNum5 INT,
           propertyNum6 INT,
           propertyTex1 STRING,
           propertyTex2 STRING,
           propertyTex3 STRING,
           propertyTex4 STRING,
           propertyTex5 STRING,
           propertyTex6 STRING,
           publisher INT,
           publishDate DATE
       )
USING csv
OPTIONS (path 'hdfs://namenode:8020/dataset/product/product_no_header.csv');



