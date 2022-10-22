const Receipt = require('../models/Receipt')

const mongoose = require('mongoose')

// can be /:  or json ?
// Show list of Receipts - selected user 
const show = (req,res,next) => {
    
    try{
        const ObjectId = mongoose.Types.ObjectId(req.params.id)
    } catch(error){
        res.json({
            message: 'Wrong user id'
        })
    }
    
    Receipt.find({userId: ObjectId})
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

module.exports = {
    store, show, destroy
}