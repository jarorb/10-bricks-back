from pydantic import BaseModel, Field

from fastapi import FastAPI, Body, Path
from fastapi.middleware.cors import CORSMiddleware

from properties import properties
from purchases import purchases

app = FastAPI()

origins = [
    "http://localhost:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

#Models
class Purchase(BaseModel):
    id_properties: int = Field(...,)
    id_user: int = Field(...,)
    id_authorization: int = Field(...,)
    id_book_purchase: int = Field(...,)
    total: float = Field(...,)
    total_bricks: int = Field(...,)

class Book(BaseModel):
    id_property: int = Field(...,)
    total_bricks: int = Field(...,)

class UpdateBook(BaseModel):
    id_property: int = Field(...,)
    total_bricks: int = Field(...,)
    id_book_purchase: int = Field(...,)


#Endpoints

#Get Endpoints
@app.get('/')
def home():
    return {'messase': 'See the documentation'}

@app.get('/properties')
def get_properties():
    res = properties.get_properties()
    return res

#Post Endpoints
@app.post('/purchases/new')
def create_purchase(purchase: Purchase = Body(...)):
    res = purchases.save_purchase(purchase)
    return res

@app.post('/purchases/book')
def create_book(book: Book = Body(...)):
    res = purchases.book_purchase(book)
    return res

#Put Endpoints
@app.put('/book/update')
def update_book(book: UpdateBook = Body(...)):
    res = purchases.update_book_purchase(book)
    return res

@app.put('/book/delivery/{id_book_purchase}')
def delivery_book(id_book_purchase: str = Path(...,),):
    res = purchases.delivery_book(id_book_purchase)
    return res



