-- Databricks notebook source
-- MAGIC %md
-- MAGIC ##### Lesson Objectives
-- MAGIC 1. Spark SQL documentation
-- MAGIC 2. Create Database demo
-- MAGIC 3. Data tab in the UI
-- MAGIC 4. SHOW command
-- MAGIC 5. DESCRIBE command
-- MAGIC 6. Find the current database

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS demo;

-- COMMAND ----------

SHOW databases;

-- COMMAND ----------

DESCRIBE DATABASE demo;

-- COMMAND ----------

DESCRIBE DATABASE EXTENDED demo;

-- COMMAND ----------

SELECT CURRENT_DATABASE();

-- COMMAND ----------

SHOW TABLES;

-- COMMAND ----------

SHOW TABLES IN demo;

-- COMMAND ----------

USE demo;

-- COMMAND ----------

SELECT CURRENT_DATABASE();

-- COMMAND ----------

SHOW TABLES;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Learning Objectives
-- MAGIC 1. Create managed table using Python
-- MAGIC 2. Create managed table using SQL
-- MAGIC 3. Effect of dropping a managed table
-- MAGIC 4. Describe table

-- COMMAND ----------

-- MAGIC %run "../includes/configuration"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Create Table using python

-- COMMAND ----------

-- MAGIC %python
-- MAGIC race_results_df = spark.read.parquet(f"{presentation_folder_path}/race_results")

-- COMMAND ----------

USE demo;
SHOW TABLES;

-- COMMAND ----------

DESC EXTENDED race_results_python1

-- COMMAND ----------

SELECT *
  FROM demo.race_results_python1
 WHERE race_year = 2020

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Create Managed Table using SQL

-- COMMAND ----------

CREATE TABLE race_results_sql
AS 
SELECT *
  FROM demo.race_results_python1
 WHERE race_year = 2020;

-- COMMAND ----------

SELECT CURRENT_DATABASE()

-- COMMAND ----------

DESC EXTENDED demo.race_results_sql;

-- COMMAND ----------

DROP TABLE demo.race_results_sql;

-- COMMAND ----------

SHOW TABLES IN demo;

-- COMMAND ----------

DROP TABLE demo.race_results_python;

-- COMMAND ----------

SHOW TABLES IN demo;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Learning Objectives
-- MAGIC 1. Create external table using Python
-- MAGIC 2. Create external table using SQL
-- MAGIC 3. Effect of dropping an external table

-- COMMAND ----------

-- MAGIC %python
-- MAGIC race_results_df.write.format("parquet").option("path", f"{presentation_folder_path}/race_results_ext_py").saveAsTable("demo.race_results_ext_py")

-- COMMAND ----------

DESC EXTENDED demo.race_results_ext_py

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Create External Table in SQL

-- COMMAND ----------

CREATE TABLE demo.race_results_ext_sql
(race_year INT,
 race_name STRING,
 race_date TIMESTAMP,
 circuit_location STRING,
 driver_name STRING,
 driver_number INT,
 driver_nationality STRING,
 team STRING,
 grid INT,
 fastest_lap INT,
 race_time STRING,
 points FLOAT,
 position INT,
 created_date TIMESTAMP


)

USING parquet 
LOCATION "/mnt/formula1dl954/presentation/race_results_ext_sql"

-- COMMAND ----------

SHOW TABLES IN demo;

-- COMMAND ----------

INSERT INTO demo.race_results_ext_sql
SELECT * FROM demo.race_results_ext_py WHERE race_year = 2020;

-- COMMAND ----------

SELECT COUNT(*) FROM demo.race_results_ext_sql;

-- COMMAND ----------

DROP TABLE demo.race_results_ext_sql

-- COMMAND ----------

SHOW TABLES IN demo;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Views on tables
-- MAGIC #### Learning Objectives
-- MAGIC 1. Create Temp View
-- MAGIC 2. Create Global Temp view
-- MAGIC 3. Create Permanent View

-- COMMAND ----------

SHOW TABLES IN demo;

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW v_race_results
AS 
  SELECT *
   FROM demo.race_results_python1
  WHERE race_year = 2018;

-- COMMAND ----------

SELECT * FROM v_race_results;

-- COMMAND ----------

CREATE OR REPLACE GLOBAL TEMP VIEW gv_race_results1
AS 
  SELECT *
   FROM demo.race_results_python1
  WHERE race_year = 2012;

-- COMMAND ----------

SELECT * FROM global_temp.gv_race_results1

-- COMMAND ----------

SHOW TABLES IN global_temp;

-- COMMAND ----------

CREATE OR REPLACE VIEW demo.pv_race_results1
AS 
  SELECT *
   FROM demo.race_results_python1
  WHERE race_year = 2000;

-- COMMAND ----------

SHOW TABLES in demo;

-- COMMAND ----------

SELECT * FROM demo.pv_race_results1

-- COMMAND ----------


