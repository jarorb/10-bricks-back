import datetime, copy
from datetime import date
from config_conn.connect import connect

def get_properties():
    errors = {}
    response = {}
    snt = "SELECT * FROM properties ORDER BY available_bricks DESC;"
    conn = connect()
    cur = conn.cursor()
    qry = cur.execute(snt)
    records = []
    columns = [column[0] for column in cur.description]
    curlfetchall = cur.fetchall()
    for row in curlfetchall:
        records.append(dict(zip(columns, row)))
    response['success'] = False if len(errors) else True
    response['data'] = False if len(errors) else records
    response['errors'] = errors if len(errors) else False

    return response



    