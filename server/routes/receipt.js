const express = require('express')
const router = express.Router()

const ReceiptController = require('../controllers/ReceiptController')
const authenticate = require('../middleware/authenticate')

//router.get('/', ReceiptController.index)
router.post('/show/:id', authenticate, ReceiptController.show)
router.post('/store/:id', authenticate, ReceiptController.store)
//router.post('/update', ReceiptController.update)
router.post('/delete/:receiptId', authenticate, ReceiptController.destroy)

module.exports = router
