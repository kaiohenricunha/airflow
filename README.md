# airflow

## Sample Data

Sample JSONL data files are included in the `input/` directory, but not committed. These files contain anonymized, example data and are used to demonstrate the input format for the pipeline and should be downloaded from this google drive[https://drive.google.com/uc?export=download&id=129VK-dupdhv0a_2xSmZl1Z_hVjffjAUI] and placed in the `input/` directory.

## Environment Variables

This project uses environment variables to securely manage credentials. You should create an `.env` file at the root of the project and add the following variables:

```
POSTGRES_DB=XXXX
POSTGRES_USER=XXXX
POSTGRES_PASSWORD=XXX
```


Replace `your_db`, `your_user`, and `your_password` with your actual Postgres credentials. This `.env` file is used by Docker Compose to set up the Postgres container and is also read by the `etl.py` script to connect to the database.

**Note**: Make sure to add `.env` to `.gitignore` so that you don't commit your credentials.
