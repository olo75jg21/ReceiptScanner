// creating table in mongodb database
const mongoose = require('mongoose')
const Schema = mongoose.Schema

/*
const item = new Schema({
    name: String,
    price: Number,
    description: {
        type: String,
        required: false
    }
})
module.exports = mongoose.model('Item', item);
*/

const receiptSchema = new Schema({
    //userId: Schema.Types.ObjectId, ref: 'user',
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