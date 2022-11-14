const Receipt = require('../models/Receipt')

const mongoose = require('mongoose')

// Show list of Receipts - selected user 
const show = (req,res,next) => {
    var ObjectId;
    try{
         ObjectId = mongoose.Types.ObjectId(req.params.userId)
    } catch(error){
        res.json({
            message: 'Wrong user id'
        })
    }
    
    Receipt.find({userId: ObjectId}, { "__v": 0, "createdAt": 0, "updatedAt": 0})
    .then(response => {
        if(response)
        {
            res.json({
                response
            })
        }else {
            res.json({
                message: 'User does not have any save receipts'
            })
        }
    })
    .catch(error => {
        res.json({
            message: 'An error occured',
            userId: req.params.id
        })
    })
}

const store = (req,res,next) => {

    var ObjectId
    try{
        ObjectId = mongoose.Types.ObjectId(req.params.userId)
    } catch(error){
        res.json({
            message: 'Wrong user id'
        })
    }
    
    let receipt = new Receipt({
        userId: ObjectId,
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


const update = (req,res,next) => {
    let receiptId = req.params.receiptId

    Receipt.findByIdAndUpdate(receiptId, {$set: { data: req.body.data, shop: req.body.shop, price: req.body.price } })
    .then(()=>{
        res.json({
            message: 'Receipt informations updated'
        })
    })
    .catch(error=>{
        res.json({
            message: 'Receipt Id does not exist'
        })
    })
}


const destroy = (req,res,next) => {
    let receiptId = req.params.receiptId

    Receipt.findByIdAndRemove(receiptId)
    .then(()=>{
        res.json({
            message: 'Receipt deleted'
        })
    })
    .catch(error => {
        res.json({
            message: 'Receipt id does not exist'
        })
    })
}

const storeItem = (req,res,next) => {
    Receipt.updateOne( {_id: req.params.receiptId}, { $push: { receiptItems: { name: req.body.name, unit: req.body.unit,
        amount: req.body.amount, priceInvidual: req.body.priceInvidual, category: req.body.category } } } ) 
    .then(()=>{
        res.json({
            message: 'Item was added to receipt',
        })
    })
    .catch(error => {
        res.json({
            message: 'Receipt id does not exist',
        })
    })
}

const updateItem = (req,res,next) => {

    Receipt.updateOne( {_id: req.params.receiptId, "receiptItems._id": req.params.itemId }, {$set: 
        {
            "receiptItems.$.name": req.body.name, 
            "receiptItems.$.unit": req.body.unit,
            "receiptItems.$.amount": req.body.amount, 
            "receiptItems.$.priceInvidual": req.body.priceInvidual, 
            "receiptItems.$.category": req.body.category 
        }
    })
    .then(()=>{
        res.json({
            message: 'Item updated',
        })
    })
    .catch(error => {
        res.json({
            message: 'Receipt id or Item id does not exist',
        })
    })
}

const destroyItem = (req,res,next) => {
    Receipt.updateOne( {_id: req.params.receiptId}, {$pull: { receiptItems: { _id: req.params.itemId } } } )
    .then(()=>{
        res.json({
            message: 'Item removed from receipt',
        })
    })
    .catch(error => {
        res.json({
            message: 'Receipt id or Item id does not exist',
        })
    })
}

module.exports = {
    store, show, destroy, update, destroyItem, storeItem, updateItem
}