const express = require('express')
const router = express.Router()

const ReceiptController = require('../controllers/ReceiptController')
const authenticate = require('../middleware/authenticate')

// authenticate - temporary deleted
router.get('/:userId', ReceiptController.show)

router.post('/:userId', ReceiptController.store)
router.post('/item/:receiptId', ReceiptController.storeItem)

router.patch('/:receiptId', ReceiptController.update)
router.patch('/:receiptId/item/:itemId', ReceiptController.updateItem)

router.delete('/:receiptId', ReceiptController.destroy)
router.delete('/:receiptId/item/:itemId', ReceiptController.destroyItem)

module.exports = router
