const Receipt = require('../models/Receipt')

const mongoose = require('mongoose')

// can be /:  or json ?
// Show list of Receipts - selected user 
const show = (req,res,next) => {
    var ObjectId;
    try{
         ObjectId = mongoose.Types.ObjectId(req.params.id)
    } catch(error){
        res.json({
            message: 'Wrong user id'
        })
    }
    //[{"__v": 0}, {"createdAt": 0}, {"updatedAt": 0}]
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
        ObjectId = mongoose.Types.ObjectId(req.params.id)
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
*/

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

//doesn't work 

const destroyItem = (req,res,next) => {
    const ObjectId = mongoose.Types.ObjectId(req.param.itemId)
    const obId = mongoose.Types.ObjectId("63546eb7d27b77b34ede4b20")
    Receipt.updateOne( {_id: obId}, {$pull: { receiptItems: { _id: ObjectId } } } )
    .then(()=>{
        res.json({
            message: 'Item removed from receipt',
            id: itemId
        })
    })
    .catch(error => {
        res.json({
            message: 'Item id does not exist',
            id: req.params.itemId
        })
    })
}

module.exports = {
    store, show, destroy, destroyItem
}