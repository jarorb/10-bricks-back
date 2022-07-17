## Available Scripts

### `python3 -m venv venv`
Install virtual environment

### `source venv/bin/activate`
Activate virtual environment


### `pip3 install -r requirements.txt`
Install requirements


### `uvicorn main:app --reload`
Runs the app in [http://127.0.0.1:8000/]
Open [http://127.0.0.1:8000/docs] to view the documentation in your browser.

The page will reload when you make changes.\


### `pytest`
Run the tests for this app


### `deactivate`

Deactivate virtual environment

### `pg_restore --dbname=database --clean --username=user --host=localhost --port=5432 database.sql`
You see a database.sql, this is a small PostgreSQL database for use in the app
For used it you need to rename the file databaseExample.ini to database.ini, and fill it with your database information
This file is in the dir confif_conn

### CORS
Set your origins in the origin list at the file main.py




