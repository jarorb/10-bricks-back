from fastapi.testclient import TestClient

from main import app

client = TestClient(app)

data_get_properties = {
  "success": True,
  "data": [
    {
      "id_properties": 1,
      "name": "STETRU PARK",
      "type": "Industry",
      "city": "El arenal",
      "risk_level": "B1",
      "delivery_estimated_date": "2022-11-30",
      "proyect_status": "Construction",
      "total_bricks": 10000,
      "available_bricks": 6499,
      "price_brick": 2780,
      "estimated_rent_year": 1966620,
      "image": "https://images.pexels.com/photos/129494/pexels-photo-129494.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "bricks_to_buy": 0
    },
    {
      "id_properties": 3,
      "name": "B CENTRAL 270 (PISO 8)",
      "type": "Office",
      "city": "Zapopan",
      "risk_level": "B3",
      "delivery_estimated_date": "2023-12-31",
      "proyect_status": "Construction",
      "total_bricks": 10000,
      "available_bricks": 2972,
      "price_brick": 2230,
      "estimated_rent_year": 1507202,
      "image": "https://images.pexels.com/photos/439391/pexels-photo-439391.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "bricks_to_buy": 0
    },
    {
      "id_properties": 2,
      "name": "LIVING ROMA NORTE ",
      "type": "Living",
      "city": "CDMX",
      "risk_level": "A1",
      "delivery_estimated_date": "2022-05-31",
      "proyect_status": "Finished",
      "total_bricks": 10000,
      "available_bricks": 1539,
      "price_brick": 4350,
      "estimated_rent_year": 3023314,
      "image": "https://images.pexels.com/photos/269077/pexels-photo-269077.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      "bricks_to_buy": 0
    }
  ],
  "errors": False
}
data_create_book = {
  "success": False,
  "data": False,
  "errors": [
    {},
    "Sorry someone has taken the bricks if they don't buy it, will be available in 15 minutes maximiun."
  ]
}

input_create_book = {
  "id_property": 4,
  "total_bricks": 1
}

input_update_book = {
  "id_property": 4,
  "total_bricks": 1,
  "id_book_purchase": 2
}

input_create_purchase = {
  "id_properties": 4,
  "id_user": 1,
  "id_authorization": 1,
  "id_book_purchase": 1,
  "total": 1,
  "total_bricks": 1
}
data_delivery_book = {
  "success": True,
  "data": {
    "id_book_purchase": "1"
  },
  "errors": False
}

def test_get_properties():
    response = client.get('/properties')
    assert response.status_code == 200
    assert response.json() == data_get_properties

def test_booked():
    response = client.post('/purchases/book', json=input_create_book)

    assert response.status_code == 200
    assert response.json() == data_create_book

def test_update_book():
    response = client.put('/book/update', json=input_update_book)
    assert response.status_code == 200
    assert response.json() == data_create_book

def test_create_purchase():
    response = client.post('/purchases/new', json=input_create_purchase)
    assert response.status_code == 200
    assert response.json() == data_create_book

def test_delivery_book():
    response = client.put('/book/delivery/1')
    assert response.status_code == 200
    assert response.json() == data_delivery_book