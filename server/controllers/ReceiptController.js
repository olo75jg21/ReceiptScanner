const Receipt = require('../models/Receipt')

const mongoose = require('mongoose')

// Show list of Receipts - selected user 
const show = (req, res, next) => {

    var ObjectId;
    try {
        ObjectId = mongoose.Types.ObjectId(req.params.userId)
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error'
        })
    }

    const options = {}

    if (req.query.page && req.query.limit) {
        options.page = req.query.page
        options.limit = req.query.limit
    } else {
        options.pagination = false
    }

    // Temporary code to test
    res.send([{
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
    }, {
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
    }]);

    return;

    // End of temporary code

    Receipt.paginate({ userId: ObjectId }, options, { "__v": 0, "createdAt": 0, "updatedAt": 0 })
        .then(response => {
            if (response) {
                res.status(200).json({
                    response
                })
            } else {
                res.status(204).json({
                    message: 'User does not have any receipts'
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


const update = (req, res, next) => {
    let receiptId = req.params.receiptId

    Receipt.findByIdAndUpdate(receiptId, { $set: { data: req.body.data, shop: req.body.shop, price: req.body.price } })
        .then(() => {
            res.json({
                message: 'Receipt informations updated'
            })
        })
        .catch(error => {
            res.json({
                message: 'Receipt Id does not exist'
            })
        })
}


const destroy = (req, res, next) => {
    let receiptId = req.params.receiptId

    Receipt.findByIdAndRemove(receiptId)
        .then(() => {
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

const storeItem = (req, res, next) => {
    Receipt.updateOne({ _id: req.params.receiptId }, {
        $push: {
            receiptItems: {
                name: req.body.name, unit: req.body.unit,
                amount: req.body.amount, priceInvidual: req.body.priceInvidual, category: req.body.category
            }
        }
    })
        .then(() => {
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

const updateItem = (req, res, next) => {

    Receipt.updateOne({ _id: req.params.receiptId, "receiptItems._id": req.params.itemId }, {
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

const destroyItem = (req, res, next) => {
    Receipt.updateOne({ _id: req.params.receiptId }, { $pull: { receiptItems: { _id: req.params.itemId } } })
        .then(() => {
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