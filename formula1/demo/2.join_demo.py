# Databricks notebook source
# MAGIC %run "../includes/configuration"

# COMMAND ----------

circuits_df = spark.read.parquet(f"{processed_folder_path}/circuits") \
.filter("circuitId <70") \
.withColumnRenamed("name", "circuit_name")

# COMMAND ----------

races_df = spark.read.parquet(f"{processed_folder_path}/races").filter("race_year = 2019") \
.withColumnRenamed("name", "race_name")

# COMMAND ----------

display(circuits_df)

# COMMAND ----------

display(races_df )

# COMMAND ----------

# MAGIC %md 
# MAGIC #### Inner Join

# COMMAND ----------

race_circuits_df = circuits_df.join(races_df, circuits_df.circuitId == races_df.circuit_id, "inner") \
.select(circuits_df.circuit_name, circuits_df.location, circuits_df.country, races_df.race_name, races_df.round)

# COMMAND ----------

display(race_circuits_df )

# COMMAND ----------

# MAGIC %md 
# MAGIC ### Outer Joins

# COMMAND ----------

# Left Outer Join
race_circuits_df = circuits_df.join(races_df, circuits_df.circuitId == races_df.circuit_id, "left") \
.select(circuits_df.circuit_name, circuits_df.location, circuits_df.country, races_df.race_name, races_df.round)

# COMMAND ----------

display(race_circuits_df )

# COMMAND ----------

# right Outer Join
race_circuits_df = circuits_df.join(races_df, circuits_df.circuitId == races_df.circuit_id, "right") \
.select(circuits_df.circuit_name, circuits_df.location, circuits_df.country, races_df.race_name, races_df.round)

# COMMAND ----------

display(race_circuits_df)

# COMMAND ----------

# Full Outer Join
race_circuits_df = circuits_df.join(races_df, circuits_df.circuitId == races_df.circuit_id, "full") \
.select(circuits_df.circuit_name, circuits_df.location, circuits_df.country, races_df.race_name, races_df.round)

# COMMAND ----------

display(race_circuits_df)

# COMMAND ----------

# MAGIC %md
# MAGIC ### Semi Joins

# COMMAND ----------

# Semi Join
race_circuits_df = circuits_df.join(races_df, circuits_df.circuitId == races_df.circuit_id, "semi") 

# COMMAND ----------

display(race_circuits_df )

# COMMAND ----------

# MAGIC %md
# MAGIC #### Anti Joins

# COMMAND ----------

race_circuits_df = races_df.join(circuits_df, circuits_df.circuitId == races_df.circuit_id, "anti")

# COMMAND ----------

display(race_circuits_df )

# COMMAND ----------

# MAGIC %md
# MAGIC ### Cross Joins

# COMMAND ----------

race_circuits_df = races_df.crossJoin(circuits_df)

# COMMAND ----------

display(race_circuits_df )

# COMMAND ----------


