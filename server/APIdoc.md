# API Documentation

## POST /register
Rejstracja
```JSON
{
    "firstName": "admin",
    "secondName": "admin",
    "username": "admin",
    "email": "admin@admin.de",
    "password": "admin" 
}
```

### Możliwe odpowiedzi
* "User Added Successfully"
* "Username and email already exists"
* "Username already exists"
* "Email already exists"
* 'An error occured'<br/></br>

## POST /login
Logowanie 
```JSON
{
    "username": "email@.pl",
    "password": "pass" 
}
```

### Możliwe odpowiedzi
* 'Login succesful'
* 'Password is incorrect'
* 'No user found'

### Informacje, które należy przechować w aplikacji do dalszej pracy
* token
* id

Token potrzebny będzie do autoryzacji, musi znajdować się w Headerze 

Id użytkownika jest używane, aby dostać paragony<br/><br/>

# POST /receipt/{idUzytkownika}
Dodanie paragonu
```JSON
{
    "shop": "zabka",
    "price": 120,
    "receiptItems": [
        {
            "name": "snickers",
            "unit": ".szt",
            "amount": 1,
            "priceInvidual": 2,
            "category": "slodycze"
        },
        {
            "name": "lizak",
            "unit": ".szt",
            "amount": 1,
            "priceInvidual": 1,
            "category": "slodycze"
        },
        {
            "name": "prince",
            "unit": ".szt",
            "amount": 1,
            "priceInvidual": 1.5,
            "category": "slodycze"
        }
    ]
}
```

### Możliwe odpowiedzi 
* 'Wrong user id'
* "Receipt added"
* 'An error occured'<br/><br/>

# GET /receipt/{idUzytkownika}
Pobranie wszystkich paragonów danego użytkownika
```JSON
{
    "response": [
        {
            "_id": "63543e238f4924aa537bab5c",
            "userId": "635431494b9265ce3f320620",
            "shop": "zabka",
            "price": 120,
            "receiptItems": [
                {
                    "name": "snickers",
                    "unit": ".szt",
                    "amount": 1,
                    "priceInvidual": 2,
                    "category": "slodycze",
                    "_id": "63543e238f4924aa537bab5d"
                }
            ],
            "data": "2022-10-22T19:01:55.451Z",
        },
        {
            "_id": "63545983d81af0f9f1f964e1",
            "userId": "635431494b9265ce3f320620",
            "shop": "zabka",
            "price": 120,
            "receiptItems": [
                {
                    "name": "snickers",
                    "unit": ".szt",
                    "amount": 1,
                    "priceInvidual": 2,
                    "category": "slodycze",
                    "_id": "63545983d81af0f9f1f964e2"
                }
            ],
            "data": "2022-10-22T20:58:43.329Z",
        }
    ]
}
```

ukryte pola "__v", "createdAt" oraz "updatedAt"<br/><br/>

# DELETE /receipt/{idParagonu}
 Usuniecie paragonu
### Możliwe odpowiedzi 
* 'Receipt deleted'
* 'Receipt id does not exist'<br/><br/>

# DELETE /receipt/{idParagonu}/item/{idPrzedmiotu}
Usuniecie przedmiotu z paragonu

### Możliwe odpowiedzi 
* 'Item removed from receipt',
* 'Receipt id or Item id does not exist'<br/><br/>

# POST /receipt/item/{idParagonu}
Dodanie przedmiotu do paragonu
```JSON
{
    "name": "batonik",
    "unit": ".szt",
    "amount": 5,
    "priceInvidual": 2.3,
    "category": "slodycze"
}
```

### Możliwe odpowiedzi 
* 'Item was added to receipt',
* 'Receipt id does not exist'<br/><br/>

# PATCH /receipt/{idParagonu}
Aktualizacja paragonu
```JSON
{
   "shop": "zabka",
   "price": 3.50,
   "data": "2020-10-03"
}
```

### Możliwe odpowiedzi 
* 'Receipt informations updated'
* 'Receipt id does not exist'<br/><br/>

# PATCH /receipt/{idParagonu}/item/{idPrzedmiotu}
Aktualizacja przedmiotu w danym paraganie
```JSON
{
   "name": "baton",
   "unit": ".szt",
   "amount": 3,
   "priceInvidual": 1.5,
   "category": "slodycze"
}
```

### Możliwe odpowiedzi 
* 'Item updated'
* 'Receipt id or item id does not exist'



