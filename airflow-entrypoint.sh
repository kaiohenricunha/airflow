#!/bin/bash
set -e

# Initialize Airflow DB
airflow db init

if [ -z "$POSTGRES_USER" ]; then
  echo "Error: POSTGRES_USER is not set."
  exit 1
fi

if [ -z "$POSTGRES_PASSWORD" ]; then
  echo "Error: POSTGRES_PASSWORD is not set."
  exit 1
fi

# Create Airflow user
airflow users create \
    --username $POSTGRES_USER \
    --firstname John \
    --lastname Doe \
    --role Admin \
    --email admin@example.com \
    --password $POSTGRES_PASSWORD

# Start Airflow web server
exec airflow webserver
