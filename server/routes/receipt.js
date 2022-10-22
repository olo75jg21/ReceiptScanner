const express = require('express')
const router = express.Router()

const ReceiptController = require('../controllers/ReceiptController')
const authenticate = require('../middleware/authenticate')

/*
router.post('/show/:id', authenticate, ReceiptController.show)
router.post('/store/:id', authenticate, ReceiptController.store)
router.post('/delete/:receiptId', authenticate, ReceiptController.destroy)
router.post('/delete/item/:itemId', ReceiptController.destroyItem)
*/

router.post('/show/:id', ReceiptController.show)
router.post('/store/:id', ReceiptController.store)
router.post('/delete/:receiptId', ReceiptController.destroy)
router.post('/delete/:receiptId/item/:itemId', ReceiptController.destroyItem)

module.exports = router
