const express = require('express')
const router = express.Router()

const ReceiptController = require('../controllers/ReceiptController')
const authenticate = require('../middleware/authenticate')

// authenticate - temporary deleted
router.get('/:userId', ReceiptController.show)

router.post('/:userId', authenticate, ReceiptController.store)
router.post('/item/:receiptId', authenticate, ReceiptController.storeItem)

router.patch('/:receiptId', authenticate, ReceiptController.update)
router.patch('/:receiptId/item/:itemId', authenticate, ReceiptController.updateItem)

router.delete('/:receiptId', authenticate, ReceiptController.destroy)
router.delete('/:receiptId/item/:itemId', authenticate, ReceiptController.destroyItem)

module.exports = router
