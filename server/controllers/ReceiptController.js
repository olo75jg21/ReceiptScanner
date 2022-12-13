const Receipt = require('../models/Receipt')

const mongoose = require('mongoose')

// Show list of Receipts - selected user 
const show = (req, res, next) => {

    var ObjectId;
    try {
        ObjectId = mongoose.Types.ObjectId(req.params.userId)
    } catch (error) {
        res.status(404).json({
            message: 'Resource was not found'
        })
    }

    const options = {}

    if (req.query.page && req.query.limit) {
        options.page = req.query.page
        options.limit = req.query.limit
    } else {
        options.pagination = false
    }

    Receipt.paginate({ userId: ObjectId }, options, { "__v": 0, "createdAt": 0, "updatedAt": 0 })
        .then(response => {
            if (response) {
                res.status(200).json({
                    response
                })
            } else {
                res.status(404).json({
                    message: "You don't have any receipts yet"
                })
            }
        })
        .catch(error => {
            res.status(500).json({
                message: 'Internal server error',
            })
        })
}

const store = (req, res, next) => {

    var ObjectId
    try {
        ObjectId = mongoose.Types.ObjectId(req.params.userId)
    } catch (error) {
        res.status(404).json({
            message: 'Resource was not found'
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
            res.status(201).json({
                message: "Receipt was added successfully"
            })
        })
        .catch(error => {
            res.status(500).json({
                message: 'Internal server error'
            })
        })
}


const update = (req, res, next) => {

    var receiptId
    try {
        receiptId = mongoose.Types.ObjectId(req.params.receiptId)
    } catch (error) {
        res.status(404).json({
            message: 'Resource was not found'
        })
    }

    Receipt.findByIdAndUpdate(receiptId, { $set: { data: req.body.data, shop: req.body.shop, price: req.body.price } })
        .then(() => {
            res.status(200).json({
                message: "Receipt informations was updated successfully"
            })
        })
        .catch(error => {
            res.status(500).json({
                message: "Internal server error"
            })
        })
}

const destroy = (req, res, next) => {

    var receiptId
    try {
        receiptId = mongoose.Types.ObjectId(req.params.receiptId)
    } catch (error) {
        res.status(404).json({
            message: 'Resource was not found'
        })
    }

    Receipt.findByIdAndRemove(receiptId)
        .then(() => {
            res.status(200).json({
                message: 'Receipt was deleted successfully'
            })
        })
        .catch(error => {
            res.status(500).json({
                message: 'Internal server error'
            })
        })
}

const storeItem = (req, res, next) => {

    var receiptId
    try {
        receiptId = mongoose.Types.ObjectId(req.params.receiptId)
    } catch (error) {
        res.status(404).json({
            message: 'Resource was not found'
        })
    }

    Receipt.updateOne({ _id: receiptId }, {
        $push: {
            receiptItems: {
                name: req.body.name, unit: req.body.unit,
                amount: req.body.amount, priceInvidual: req.body.priceInvidual, category: req.body.category
            }
        }
    })
        .then(() => {
            res.status(200).json({
                message: 'Item was added to receipt successfully',
            })
        })
        .catch(error => {
            res.status(500).json({
                message: 'Internal server error',
            })
        })
}

const updateItem = (req, res, next) => {

    var receiptId
    try {
        receiptId = mongoose.Types.ObjectId(req.params.receiptId)
    } catch (error) {
        res.status(404).json({
            message: 'Resource was not found'
        })
    }

    var itemId
    try {
        itemId = mongoose.Types.ObjectId(req.params.itemId)
    } catch (error) {
        res.status(404).json({
            message: 'Resource was not found'
        })
    }

    Receipt.updateOne({ _id: receiptId, "receiptItems._id": itemId }, {
        $set:
        {
            "receiptItems.$.name": req.body.name,
            "receiptItems.$.unit": req.body.unit,
            "receiptItems.$.amount": req.body.amount,
            "receiptItems.$.priceInvidual": req.body.priceInvidual,
            "receiptItems.$.category": req.body.category
        }
    })
        .then(() => {
            res.status(200).json({
                message: 'Item was updated successfully',
            })
        })
        .catch(error => {
            res.status(500).json({
                message: 'Internal server error',
            })
        })
}

const destroyItem = (req, res, next) => {

    var receiptId
    try {
        receiptId = mongoose.Types.ObjectId(req.params.receiptId)
    } catch (error) {
        res.status(404).json({
            message: 'Resource was not found'
        })
    }

    var itemId
    try {
        itemId = mongoose.Types.ObjectId(req.params.itemId)
    } catch (error) {
        res.status(404).json({
            message: 'Resource was not found'
        })
    }

    Receipt.updateOne({ _id: receiptId }, { $pull: { receiptItems: { _id: itemId } } })
        .then(() => {
            res.status(200).json({
                message: 'Item was removed from receipt successfully',
            })
        })
        .catch(error => {
            res.status(404).json({
                message: 'Internal server error',
            })
        })
}

module.exports = {
    store, show, destroy, update, destroyItem, storeItem, updateItem
}