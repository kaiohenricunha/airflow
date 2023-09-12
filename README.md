# airflow

## Sample Data

Sample JSONL data files are included in the `input/` directory, but not committed. These files contain anonymized, example data and are used to demonstrate the input format for the pipeline and should be downloaded from this google drive[https://drive.google.com/uc?export=download&id=129VK-dupdhv0a_2xSmZl1Z_hVjffjAUI] and placed in the `input/` directory.

This is an example of the data format:

```json
{"ordem": "C51641", "latitude": "-22,87652", "longitude": "-43,36818", "datahora": "1684119592000", "velocidade": "37", "linha": "LECD36", "datahoraenvio": "1684119600000", "datahoraservidor": "1684119620000"}
{"ordem": "C51610", "latitude": "-22,87647", "longitude": "-43,36824", "datahora": "1684119581000", "velocidade": "0", "linha": "GARAGEM", "datahoraenvio": "1684119600000", "datahoraservidor": "1684119620000"}
```

## Environment Variables

This project uses environment variables to securely manage credentials. You should create an `.env` file at the root of the project and add the following variables:

```
POSTGRES_DB=XXXX
POSTGRES_USER=XXXX
POSTGRES_PASSWORD=XXX
```


Replace `your_db`, `your_user`, and `your_password` with your actual Postgres credentials. This `.env` file is used by Docker Compose to set up the Postgres container and is also read by the `etl.py` script to connect to the database.

**Note**: Make sure to add `.env` to `.gitignore` so that you don't commit your credentials.

## Running the Project with Docker

### Prerequisites

1. Ensure that Docker is installed on your machine.
2. **Important**: Make sure the Docker daemon is running before proceeding.

### Step 1: Start Docker Containers

1. Navigate to the project root directory where the `docker-compose.yml` file is located.
2. Run the following command to start the services in detached mode:
    ```bash
    docker-compose up -d
    ```

### Step 2: Access Airflow Web UI

1. Open your web browser and navigate to `http://localhost:8080` (or the port you've configured for Apache Airflow). It may take a few seconds for the web server to start.
2. You should see the Apache Airflow web UI. Your DAG should be listed there, identified by its ID (`bus_data_pipeline` if you followed the `etl.py` example).

### Step 3: Trigger DAG

1. In the Airflow UI, find your DAG and click on it.
2. Press the "Trigger DAG" button to manually start the DAG.

### Step 4: Monitor Execution

1. Click on the "Graph View" or "Tree View" to see the tasks in your DAG.
2. You should see the `transform_data` and `load_to_db` tasks. Their color will change based on their status (e.g., dark green for success, red for failure).

### Step 5: Check Postgres Data (Optional)

1. If you want to double-check that the data was loaded into Postgres, you can use a tool like `psql` to connect to your Postgres container.
    ```bash
    docker exec -it <postgres_container_id> psql -U your_user -d your_db
    ```
2. Run SQL queries to verify the data.
    ```sql
    SELECT * FROM bus_data LIMIT 5;
    ```

### Step 6: Run SQL Queries

1. You can also execute the SQL queries (`q1.sql`, `q2.sql`, `q3.sql`, `q4.sql`) against your Postgres container to check if they return the expected results.

### Step 7: Check Logs (Optional)

1. To see logs for your Airflow or Postgres container, you can run:
    ```bash
    docker logs <container_id>
    ```
