import psycopg2
from config_conn.connect import connect

def check_availability(total_bricks, id_property):
    errors = []
    data = {}
    response = {}
    available_bricks = 0
    snt_boked = """select COALESCE(sum(total_bricks), 0) from books_purchases
                        where id_property = {} and valid = 1 and expiration_date > NOW();""".format(id_property)
    
    snt_available = """select available_bricks from properties
                        where id_properties = {};""".format(id_property)
    conn = None
    try:
        conn = connect()
        cur = conn.cursor()
        cur.execute(snt_boked)
        booked_bricks = cur.fetchone()[0]
        cur.execute(snt_available)
        available_bricks = cur.fetchone()[0]
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        errors.append(error)
    finally:
        if conn is not None:
            conn.close
    total_available = available_bricks - booked_bricks
    if total_available < total_bricks:
        error = "Sorry someone has taken the bricks if they don't buy it, will be available in 15 minutes maximiun."
        error_complement = ' Or you can try with {} bricks'.format(total_available) if total_available > 0 else ''
        errors.append(error + error_complement)
    data['booked_bricks'] = booked_bricks
    data['available_bricks'] = available_bricks
    response['success'] = False if len(errors) else True
    response['data'] = False if len(errors) else data
    response['errors'] = errors if len(errors) else False
    return response

def check_authorization(purchase):
    return True

def save_purchase(purchase):
    errors = []
    data = {}
    response = {}
    purchase_dict = purchase.dict()
    total_bricks = purchase_dict['total_bricks']
    id_property = purchase_dict['id_properties']
    id_book_purchase = purchase_dict['id_book_purchase']
    availability = check_availability(total_bricks, id_property)
    if availability['success']:
        insert = """insert into purchases (id_properties, id_user, total, total_bricks, id_authorization, "date", status)
                        values ({id_properties}, {id_user}, {total}, {total_bricks}, {id_authorization}, NOW(), 'Valid')
                        RETURNING id_purchases;""".format(**purchase_dict)

        update_availability = """update properties set available_bricks = available_bricks - {}
                                    where id_properties = {};""".format(total_bricks, id_property)

        update_book = "update books_purchases set valid = 0 where id_book_purchase = {};".format(id_book_purchase)
        conn = None
        try:
            conn = connect()
            cur = conn.cursor()
            cur.execute(insert)
            data['id_purchase'] = cur.fetchone()[0]
            cur.execute(update_availability)
            cur.execute(update_book)
            conn.commit()
            cur.close()
        except (Exception, psycopg2.DatabaseError) as error:
            errors.append(error)
        finally:
            if conn is not None:
                conn.close
    else:
        errors = errors + availability['errors']

    response['success'] = False if len(errors) else True
    response['data'] = False if len(errors) else data
    response['errors'] = errors if len(errors) else False
    return response

def book_purchase(book):
    errors = []
    data = {}
    response = {}
    book_dict = book.dict()
    total_bricks = book_dict['total_bricks']
    id_property = book_dict['id_property']
    availability = check_availability(total_bricks, id_property)
    if availability['success']:
        snt = """insert into books_purchases (id_property, total_bricks, create_date, expiration_date, valid)
                    values ({}, {}, NOW(), (select current_timestamp + (15 * interval '1 minute')), 1)
                    RETURNING id_book_purchase;""".format(id_property, total_bricks)
        conn = None
        try:
            conn = connect()
            cur = conn.cursor()
            cur.execute(snt)
            data['id_book_purchase'] = cur.fetchone()[0]
            conn.commit()
            cur.close()
        except (Exception, psycopg2.DatabaseError) as error:
            errors.append(error)
        finally:
            if conn is not None:
                conn.close
    else:
        errors = errors + availability['errors']

    response['success'] = False if len(errors) else True
    response['data'] = False if len(errors) else data
    response['errors'] = errors if len(errors) else False
    return response

def update_book_purchase(book):
    errors = []
    data = {}
    response = {}
    book_dict = book.dict()
    total_bricks = book_dict['total_bricks']
    id_property = book_dict['id_property']
    id_book_purchase = book_dict['id_book_purchase']
    availability = check_availability(total_bricks, id_property)
    if availability['success']:
        snt = """update books_purchases set total_bricks = {} where id_book_purchase = {};""".format(total_bricks, id_book_purchase)
        conn = None
        try:
            conn = connect()
            cur = conn.cursor()
            cur.execute(snt)
            data['id_book_purchase'] = id_book_purchase
            conn.commit()
            cur.close()
        except (Exception, psycopg2.DatabaseError) as error:
            errors.append(error)
        finally:
            if conn is not None:
                conn.close
    else:
        errors = errors + availability['errors']

    response['success'] = False if len(errors) else True
    response['data'] = False if len(errors) else data
    response['errors'] = errors if len(errors) else False
    return response

def delivery_book(id_book_purchase):
    errors = []
    data = {}
    response = {}
    snt = """update books_purchases set valid = 0 where id_book_purchase = {};""".format(id_book_purchase)
    conn = None
    try:
        conn = connect()
        cur = conn.cursor()
        cur.execute(snt)
        data['id_book_purchase'] = id_book_purchase
        conn.commit()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        errors.append(error)
    finally:
        if conn is not None:
            conn.close

    response['success'] = False if len(errors) else True
    response['data'] = False if len(errors) else data
    response['errors'] = errors if len(errors) else False
    return response