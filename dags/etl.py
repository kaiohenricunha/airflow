from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from datetime import datetime
import pandas as pd
import jsonlines
import psycopg2
import os

# Function to transform data
def transform_data():
    dfs = []
    with jsonlines.open('/usr/local/airflow/dags/input/bus-api/data.jsonl') as reader:
        for obj in reader:
            dfs.append(pd.DataFrame.from_dict(obj))
    
    df = pd.concat(dfs, ignore_index=True)
    df['day'] = pd.to_datetime(df['timestamp']).dt.date
    df.to_csv('/usr/local/airflow/dags/input/bus-api/transformed_data.csv', index=False)

# Function to load data into the database
def load_to_db():
    postgres_hook = PostgresHook(postgres_conn_id='your_postgres_connection_id')
    df = pd.read_csv('/usr/local/airflow/dags/input/bus-api/transformed_data.csv')
    df.to_sql('bus_data', postgres_hook.get_conn(), index=False, if_exists='replace')

# DAG definition
default_args = {
    'start_date': datetime(2023, 5, 15),
}

dag = DAG(
    'bus_data_pipeline',
    default_args=default_args,
    description='Bus Data ETL',
    schedule_interval=None,
)

transform_task = PythonOperator(
    task_id='transform_data',
    python_callable=transform_data,
    dag=dag,
)

load_task = PythonOperator(
    task_id='load_to_db',
    python_callable=load_to_db,
    dag=dag,
)

transform_task >> load_task
