#!/bin/bash

# Make the script executable
chmod +x /airflow-entrypoint.sh

# Initialize the Airflow database and create a user
airflow db init
airflow users create \
    --username $POSTGRES_USER \
    --firstname John \
    --lastname Doe \
    --role Admin \
    --email admin@example.com \
    --password $POSTGRES_PASSWORD

# Start Airflow
exec /entrypoint
