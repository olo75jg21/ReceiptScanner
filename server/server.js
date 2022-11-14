// calling packages
const express = require('express')
const mongoose = require('mongoose')
const morgan = require('morgan')
const bodyParser = require('body-parser')

//const ReceiptRoute = require('./routes/receipt')
const AuthRoute = require('./routes/auth')
const ReceiptRoute = require('./routes/receipt')

// connect to mondodb 
mongoose.connect('mongodb://localhost:27017/testdb', {useNewUrlParser: true, useUnifiedTopology: true})
const db = mongoose.connection

// handle errors database
db.on('error',(err) => {
    console.log(err)
})

// when connected to database
db.once('open', () => {
    console.log('Database Connection Established')
})

const app = express()

app.use(morgan('dev'))
app.use(bodyParser.urlencoded({extended: true}))
app.use(bodyParser.json())
app.use('/uploads', express.static('uploads'))

const PORT = process.env.PORT || 3000

app.listen(PORT, ()=> {
    console.log(`Server is running on port ${PORT}`)
})

app.use('/receipt', ReceiptRoute)
app.use('', AuthRoute)
