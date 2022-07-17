import psycopg2
from . import config

def test_connect():
    # Connect to the Postgresql database server

    conn = None
    try:
        #read conncection parameters
        params = config.config()

        #connect to the Postgresql server
        conn = psycopg2.connect(**params)

        #create a cursor
        cur = conn.cursor()

        #execute a statment
        cur.execute('SELECT version()')
        db_version = cur.fetchone()

        #display the Postgresql database server version
        print(f'Postgresql database version: {db_version}')

        #close the comunication with the Postgresql
        cur.close()

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed')

def connect():
    # Connect to the Postgresql database server

    conn = None
    try:
        #read conncection parameters
        params = config.config()

        #connect to the Postgresql server
        conn = psycopg2.connect(**params)

        #create a cursor
        #scur = conn.cursor()

        return conn

    except (Exception, psycopg2.DatabaseError) as error:
        return error

if __name__ == '__main__':
    connect()
