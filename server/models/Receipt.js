// creating table in mongodb database
const mongoose = require('mongoose')
const Schema = mongoose.Schema

const receiptSchema = new Schema({
    userId: {
        type: Schema.Types.ObjectId, 
        ref: 'User'
    },
    data: {
        type: Date,
        default: Date.now
    },
    shop: String,
    price: Number,
    receiptItems: [{
        name: String,
        unit: String,
        // can be amount of ".szt" or "kg"
        amount: Number,
        priceInvidual: Number,
        category: String
        }
    ] 
}, {timestamps: true})

const Receipt = mongoose.model('Receipt', receiptSchema)
module.exports = Receipt