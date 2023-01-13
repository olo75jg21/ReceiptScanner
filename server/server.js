// calling packages
const express = require('express')
const mongoose = require('mongoose')
const morgan = require('morgan')
const bodyParser = require('body-parser')

const AuthRoute = require('./routes/auth')
const ReceiptRoute = require('./routes/receipt')

const url = `mongodb+srv://receiptScanner:otmQO5YqE2OhQsh7@cluster0.w1oqfry.mongodb.net/?retryWrites=true&w=majority`

const connectionParams={
    useNewUrlParser: true,
    useUnifiedTopology: true 
}
mongoose.connect(url,connectionParams)
    .then( () => {
        console.log('Connected to the database ')
    })
    .catch( (err) => {
        console.error(`Error connecting to the database. n${err}`);
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
