const express = require('express')
const router = express.Router()

const ReceiptController = require('../controllers/ReceiptController')
const authenticate = require('../middleware/authenticate')


router.get('/show/:userId', authenticate,  ReceiptController.show)

router.post('/store/:userId', authenticate, ReceiptController.store)
router.post('/store/item/:receiptId', authenticate, ReceiptController.updateItem)

router.post('/update/:receiptId', authenticate, ReceiptController.update)
router.post('/update/:receiptId/item/:itemId', authenticate, ReceiptController.updateItem)

router.get('/delete/:receiptId', authenticate, ReceiptController.destroy)
router.get('/delete/:receiptId/item/:itemId', authenticate, ReceiptController.destroyItem)


module.exports = router
