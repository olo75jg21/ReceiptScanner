# API Documentation

API jest hostowane na stronie render.com
Aby użyć API należy użyć przedrostka https://receipt-scanner-api.onrender.com

## POST /register

Rejstracja

```JSON
{
    "email": "admin@test.pl",
    "password": "Admintest@1"
}
```

### Walidacja danych

- email - musi mieć prawidłowy format adresu email np. test@gmail.com
- password - długość co najmniej osiem, co najmniej jedna mała i wielka litera oraz co najmniej jeden symbol i znak

### Odpowiedzi dotyczące walidacji

Błędy przekazywane są w tablicy - mogą pojawić się obie informacje naraz w jednej odpowiedzi

- <font color="red"> Status 400 </font> "Invalid email"
- <font color="red"> Status 400 </font> "Password is too weak - minimum length have to be 8 and contains at least one Lowercase, Uppercase, Number and Symbol"

### Możliwe odpowiedzi

- <font color="green"> Status 201 </font> "Account was created, email confirmation was sent"
- <font color="red"> Status 409 </font> "Email already exists"
- <font color="red"> Status 500 </font> "Internal server error"<br/></br>

## POST /login

Logowanie

```JSON
{
    "email": "admin@test.pl",
    "password": "Admintest@1"
}
```

### Możliwe odpowiedzi

- <font color="green">Status 200 </font> "Successfully logged in"
- <font color="red"> Status 401 </font> "Invalid credentials"
- <font color="red"> Status 500 </font> "Internal server error"

### Informacje, które należy przechować w aplikacji do dalszej pracy

- token
- id

Token potrzebny będzie do autoryzacji pozostałych requestów, musi znajdować się w Headerze

Id użytkownika jest używane, aby dostać paragony<br/><br/>

# GET /verify/{userId}/{uniqueString}

Służy do potwierdzenia adresu email - przycisk w mailu "Confirm Account"

### Możliwe odpowiedzi

##### Otwarcie strony "verified.html" z sukcesem weryfikacji maila

- <font color="green">Status 200 </font>

##### Przekierowanie do "verified.html" z błędem podczas weryfikacja maila

- <font color="orange"> Status 302 </font>

# GET /verified

Otwiera widok "verified.html" w przeglądarce

### Możliwa odpowiedz

##### Otwarcie strony "verified.html" z sukcesem weryfikacji maila

- <font color="green">Status 200 </font><br/><br/>

# POST /sendPasswordReset

```JSON
{
    "email": "admin@test.pl",
    "newPassword": "Admintest@1"
}
```

### Walidacja danych

- email - musi mieć prawidłowy format adresu email np. test@gmail.com
- newPassword - długość co najmniej osiem, co najmniej jedna mała i wielka litera oraz co najmniej jeden symbol i znak

### Odpowiedzi dotyczące walidacji

Błędy przekazywane są w tablicy - mogą pojawić się obie informacje naraz w jednej odpowiedzi

- <font color="red"> Status 400 </font> "Invalid email"
- <font color="red"> Status 400 </font> "New password is too weak - minimum length have to be 8 and contains at least one Lowercase, Uppercase, Number and Symbol"

### Możliwe odpowiedzi

- <font color="green">Status 200 </font> "Password reset confirmation email was sent"
- <font color="red"> Status 401 </font> "Email hasn't been verified yet. Check your inbox"
- <font color="red"> Status 403 </font> "Wrong credentials"
- <font color="red"> Status 500 </font> "Internal server error"<br/><br/>

# GET resetPassword/{userId}/{resetString}

Służy do potwierdzenia zmiany hasła - przycisk w mailu "Reset Password"

### Możliwe odpowiedzi

##### Otwarcie strony "changedPassword.html" z sukcesem zmiany hasła

- <font color="green">Status 200 </font>

##### Przekierowanie do "verified.html" z błędem podczas zmiany hasła

- <font color="orange"> Status 302 </font>

# GET reset

Otwiera widok "changedPassword.html" w przeglądarce

### Możliwa odpowiedz

##### Otwarcie strony "changedPassword.html" z sukcesem zmiany hasła

- <font color="green">Status 200 </font><br/><br/>

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

- <font color="green"> Status 201 </font> "Receipt added"
- <font color="red"> Status 401 </font> "Authentication failed"
- <font color="red"> Status 404 </font> "Resource was not found"
- <font color="red"> Status 500 </font> "Internal server error" <br/><br/>

# GET /receipt/{idUzytkownika}?page={pageNumber}&limit={amountOfRecordsPerPage}

```JSON
{
    "response": {
        "docs": [
            {
                "_id": "6390d6e6702dc655aa70ba3c",
                "userId": "638f9860688bf896fec35464",
                "shop": "zabka",
                "price": 120,
                "receiptItems": [
                    {
                        "name": "snickers",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 2,
                        "category": "slodycze",
                        "_id": "6390d6e6702dc655aa70ba3d"
                    },
                    {
                        "name": "lizak",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1,
                        "category": "slodycze",
                        "_id": "6390d6e6702dc655aa70ba3e"
                    },
                    {
                        "name": "prince",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1.5,
                        "category": "slodycze",
                        "_id": "6390d6e6702dc655aa70ba3f"
                    }
                ],
                "data": "2022-12-07T18:09:42.981Z",
                "createdAt": "2022-12-07T18:09:42.987Z",
                "updatedAt": "2022-12-07T18:09:42.987Z",
                "__v": 0
            },
            {
                "_id": "6390d6fd702dc655aa70ba41",
                "userId": "638f9860688bf896fec35464",
                "shop": "biedronka",
                "price": 120,
                "receiptItems": [
                    {
                        "name": "snickers",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 2,
                        "category": "slodycze",
                        "_id": "6390d6fd702dc655aa70ba42"
                    },
                    {
                        "name": "lizak",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1,
                        "category": "slodycze",
                        "_id": "6390d6fd702dc655aa70ba43"
                    },
                    {
                        "name": "prince",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1.5,
                        "category": "slodycze",
                        "_id": "6390d6fd702dc655aa70ba44"
                    }
                ],
                "data": "2022-12-07T18:10:05.059Z",
                "createdAt": "2022-12-07T18:10:05.060Z",
                "updatedAt": "2022-12-07T18:10:05.060Z",
                "__v": 0
            }
        ],
        "totalDocs": 22,
        "limit": 2,
        "totalPages": 11,
        "page": 1,
        "pagingCounter": 1,
        "hasPrevPage": false,
        "hasNextPage": true,
        "prevPage": null,
        "nextPage": 2
    }
}
```

## GET /receipt/{idUzytkownika}

Pobranie wszystkich paragonów danego użytkownika

```JSON
{
    "response": {
        "docs": [
            {
                "_id": "6390d6e6702dc655aa70ba3c",
                "userId": "638f9860688bf896fec35464",
                "shop": "zabka",
                "price": 120,
                "receiptItems": [
                    {
                        "name": "snickers",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 2,
                        "category": "slodycze",
                        "_id": "6390d6e6702dc655aa70ba3d"
                    },
                    {
                        "name": "lizak",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1,
                        "category": "slodycze",
                        "_id": "6390d6e6702dc655aa70ba3e"
                    },
                    {
                        "name": "prince",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1.5,
                        "category": "slodycze",
                        "_id": "6390d6e6702dc655aa70ba3f"
                    }
                ],
                "data": "2022-12-07T18:09:42.981Z",
                "createdAt": "2022-12-07T18:09:42.987Z",
                "updatedAt": "2022-12-07T18:09:42.987Z",
                "__v": 0
            },
            {
                "_id": "6390d6fd702dc655aa70ba41",
                "userId": "638f9860688bf896fec35464",
                "shop": "biedronka",
                "price": 120,
                "receiptItems": [
                    {
                        "name": "snickers",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 2,
                        "category": "slodycze",
                        "_id": "6390d6fd702dc655aa70ba42"
                    },
                    {
                        "name": "lizak",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1,
                        "category": "slodycze",
                        "_id": "6390d6fd702dc655aa70ba43"
                    },
                    {
                        "name": "prince",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1.5,
                        "category": "slodycze",
                        "_id": "6390d6fd702dc655aa70ba44"
                    }
                ],
                "data": "2022-12-07T18:10:05.059Z",
                "createdAt": "2022-12-07T18:10:05.060Z",
                "updatedAt": "2022-12-07T18:10:05.060Z",
                "__v": 0
            },
            {
                "_id": "6390d701702dc655aa70ba46",
                "userId": "638f9860688bf896fec35464",
                "shop": "netto",
                "price": 120,
                "receiptItems": [
                    {
                        "name": "snickers",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 2,
                        "category": "slodycze",
                        "_id": "6390d701702dc655aa70ba47"
                    },
                    {
                        "name": "lizak",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1,
                        "category": "slodycze",
                        "_id": "6390d701702dc655aa70ba48"
                    },
                    {
                        "name": "prince",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1.5,
                        "category": "slodycze",
                        "_id": "6390d701702dc655aa70ba49"
                    }
                ],
                "data": "2022-12-07T18:10:09.897Z",
                "createdAt": "2022-12-07T18:10:09.898Z",
                "updatedAt": "2022-12-07T18:10:09.898Z",
                "__v": 0
            },
            {
                "_id": "6390d706702dc655aa70ba4b",
                "userId": "638f9860688bf896fec35464",
                "shop": "lidl",
                "price": 120,
                "receiptItems": [
                    {
                        "name": "snickers",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 2,
                        "category": "slodycze",
                        "_id": "6390d706702dc655aa70ba4c"
                    },
                    {
                        "name": "lizak",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1,
                        "category": "slodycze",
                        "_id": "6390d706702dc655aa70ba4d"
                    },
                    {
                        "name": "prince",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1.5,
                        "category": "slodycze",
                        "_id": "6390d706702dc655aa70ba4e"
                    }
                ],
                "data": "2022-12-07T18:10:14.169Z",
                "createdAt": "2022-12-07T18:10:14.170Z",
                "updatedAt": "2022-12-07T18:10:14.170Z",
                "__v": 0
            },
            {
                "_id": "6390d71d702dc655aa70ba55",
                "userId": "638f9860688bf896fec35464",
                "shop": "Krokodylek",
                "price": 120,
                "receiptItems": [
                    {
                        "name": "snickers",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 2,
                        "category": "slodycze",
                        "_id": "6390d71d702dc655aa70ba56"
                    },
                    {
                        "name": "lizak",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1,
                        "category": "slodycze",
                        "_id": "6390d71d702dc655aa70ba57"
                    },
                    {
                        "name": "prince",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1.5,
                        "category": "slodycze",
                        "_id": "6390d71d702dc655aa70ba58"
                    }
                ],
                "data": "2022-12-07T18:10:37.381Z",
                "createdAt": "2022-12-07T18:10:37.382Z",
                "updatedAt": "2022-12-07T18:10:37.382Z",
                "__v": 0
            },
            {
                "_id": "6390d724702dc655aa70ba5a",
                "userId": "638f9860688bf896fec35464",
                "shop": "Stokrotka",
                "price": 120,
                "receiptItems": [
                    {
                        "name": "snickers",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 2,
                        "category": "slodycze",
                        "_id": "6390d724702dc655aa70ba5b"
                    },
                    {
                        "name": "lizak",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1,
                        "category": "slodycze",
                        "_id": "6390d724702dc655aa70ba5c"
                    },
                    {
                        "name": "prince",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1.5,
                        "category": "slodycze",
                        "_id": "6390d724702dc655aa70ba5d"
                    }
                ],
                "data": "2022-12-07T18:10:44.139Z",
                "createdAt": "2022-12-07T18:10:44.140Z",
                "updatedAt": "2022-12-07T18:10:44.140Z",
                "__v": 0
            },
            {
                "_id": "6390d74f702dc655aa70baa0",
                "userId": "638f9860688bf896fec35464",
                "shop": "Test14",
                "price": 120,
                "receiptItems": [
                    {
                        "name": "snickers",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 2,
                        "category": "slodycze",
                        "_id": "6390d74f702dc655aa70baa1"
                    },
                    {
                        "name": "lizak",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1,
                        "category": "slodycze",
                        "_id": "6390d74f702dc655aa70baa2"
                    },
                    {
                        "name": "prince",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1.5,
                        "category": "slodycze",
                        "_id": "6390d74f702dc655aa70baa3"
                    }
                ],
                "data": "2022-12-07T18:11:27.676Z",
                "createdAt": "2022-12-07T18:11:27.677Z",
                "updatedAt": "2022-12-07T18:11:27.677Z",
                "__v": 0
            },
            {
                "_id": "6390d751702dc655aa70baa5",
                "userId": "638f9860688bf896fec35464",
                "shop": "Test15",
                "price": 120,
                "receiptItems": [
                    {
                        "name": "snickers",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 2,
                        "category": "slodycze",
                        "_id": "6390d751702dc655aa70baa6"
                    },
                    {
                        "name": "lizak",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1,
                        "category": "slodycze",
                        "_id": "6390d751702dc655aa70baa7"
                    },
                    {
                        "name": "prince",
                        "unit": ".szt",
                        "amount": 1,
                        "priceInvidual": 1.5,
                        "category": "slodycze",
                        "_id": "6390d751702dc655aa70baa8"
                    }
                ],
                "data": "2022-12-07T18:11:29.447Z",
                "createdAt": "2022-12-07T18:11:29.447Z",
                "updatedAt": "2022-12-07T18:11:29.447Z",
                "__v": 0
            }
        ],
        "totalDocs": 8,
        "offset": 0,
        "limit": 8,
        "totalPages": 1,
        "page": 1,
        "pagingCounter": 1,
        "hasPrevPage": false,
        "hasNextPage": false,
        "prevPage": null,
        "nextPage": null
    }
}
```

ukryte pola "\_\_v", "createdAt" oraz "updatedAt"

### Możliwe odpowiedzi

- <font color="green"> Status 200 </font> Zwróci plik Json jak w przykładach powyżej
- <font color="red"> Status 401 </font> "Authentication failed"
- <font color="red"> Status 404 </font> "You don't have any receipts yet"
- <font color="red"> Status 404 </font> "Resource was not found"
- <font color="red"> Status 500 </font> "Internal server error"<br/><br/>

# DELETE /receipt/{idParagonu}

Usuniecie paragonu

### Możliwe odpowiedzi

- <font color="green"> Status 200 </font> "Receipt was deleted successfully"
- <font color="red"> Status 401 </font> "Authentication failed"
- <font color="red"> Status 404 </font> "Resource was not found"
- <font color="red"> Status 500 </font> "Internal server error"<br/><br/>

# DELETE /receipt/{idParagonu}/item/{idPrzedmiotu}

Usuniecie przedmiotu z paragonu

### Możliwe odpowiedzi

- <font color="green"> Status 200 </font> "Item was removed from receipt successfully"
- <font color="red"> Status 401 </font> "Authentication failed"
- <font color="red"> Status 404 </font> "Resource was not found"
- <font color="red"> Status 500 </font> "Internal server error"<br/><br/>

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

- <font color="green"> Status 200 </font> "Item was added to receipt successfully"
- <font color="red"> Status 401 </font> "Authentication failed"
- <font color="red"> Status 404 </font> "Resource was not found"
- <font color="red"> Status 500 </font> "Internal server error"<br/><br/>

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

- <font color="green"> Status 200 </font> "Receipt informations was updated successfully"
- <font color="red"> Status 401 </font> "Authentication failed"
- <font color="red"> Status 404 </font> "Resource was not found"
- <font color="red"> Status 500 </font> "Internal server error"<br/><br/>

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

- <font color="green"> Status 200 </font> "Item was updated successfully"
- <font color="red"> Status 401 </font> "Authentication failed"
- <font color="red"> Status 404 </font> "Resource was not found"
- <font color="red"> Status 500 </font> "Internal server error"<br/><br/>

# GET /receipt/{idUzytkownika}/total/{month}/{year}

Zwraca wydaną sumę z paragonów z konkretnego miesiąca i roku

```JSON
{
    "totalSum": 600,
    "month": "12",
    "year": "2022"
}
```

### Możliwe odpowiedzi

- <font color="green"> Status 200 </font>
- <font color="red"> Status 500 </font> "Internal server error"<br/><br/>
