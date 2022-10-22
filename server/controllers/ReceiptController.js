const Receipt = require('../models/Receipt')

/*
// Show list of Receipts
const index = (req,res,next) => {
    Receipt.find()
    .then(response => {
        res.json({
            response
        })
    })
    .catch(error => {
        res.json({
            message: 'An error occured'
        })
    })
}

const show = (req,res,next) => {
    let receiptId = req.body.receiptId
    Receipt.findById(receiptId)
    .then(response => {
        res.json({
            response
        })
    })
    .catch(error=>{
        res.json({
            message: 'An error occured'
        })
    })
}
*/

const store = (req,res,next) => {
    let receipt = new Receipt({
        userId: req.body.userId,
        date: req.body.date,
        shop: req.body.shop,
        price: req.body.price,
        receiptItems: req.body.receiptItems
    })
    receipt.save()
    .then(response => {
        res.json({
            message: "Receipt added"
        })
    })
    .catch(error => {
        res.json({
            message: 'An error occured'
        })
    })
}

/*
const update = (req,res,next) => {
    let receiptId = req.body.receiptId

    let updatedData = {
        name: req.body.name
    }

    Receipt.findByIdAndUpdate(receiptId, {$set: updatedData})
    .then(()=>{
        res.json({
            message: 'Receipt updated'
        })
    })
    .catch(error=>{
        res.json({
            message: 'An error occured'
        })
    })
}

const destroy = (req,res,next) => {
    let receiptId = req.body.receiptId

    Receipt.findByIdAndRemove(receiptId)
    .then(()=>{
        req.json({
            message: 'Receipt deleted'
        })
    })
    .catch(error => {
        req.json({
            message: 'An error occured'
        })
    })
}
*/
module.exports = {
    store
    //index, show, store, update, destroy
}