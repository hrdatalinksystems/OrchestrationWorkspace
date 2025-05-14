# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "93abf88c-fa6a-4352-a225-11585099f6c0",
# META       "default_lakehouse_name": "Sales",
# META       "default_lakehouse_workspace_id": "bcc55788-6c68-4dab-b0f9-69adebb9e4c4",
# META       "known_lakehouses": [
# META         {
# META           "id": "93abf88c-fa6a-4352-a225-11585099f6c0"
# META         }
# META       ]
# META     }
# META   }
# META }

# PARAMETERS CELL ********************

table_name = "sales"

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from pyspark.sql.functions import *

df = spark.read.format("csv").option("header", "true").load("Files/new_data/*.csv")

df = df.withColumn("Year", year(col("OrderDate"))).withColumn("Month", month(col("OrderDate")))

df = df.withColumn("FirstName", split(col("CustomerName"), " ").getItem(0)) \
        .withColumn("LastName", split(col("CustomerName"), " ").getItem(1))

df = df["SalesOrderNumber", "SalesOrderLineNumber", "OrderDate", "Year", "Month", "FirstName", "LastName", "EmailAddress", "Item", "Quantity", "UnitPrice", "TaxAmount"]

display(df)

df.write.format("delta").mode("append").saveAsTable(table_name)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
