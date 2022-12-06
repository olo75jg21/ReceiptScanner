const express = require('express')
const router = express.Router()

const AuthController = require('../controllers/AuthController')

const { check, validationResult } = require('express-validator');

router.post('/register', [
    check('email', 'Invalid email').isEmail(),
    check('password', 'Password is too weak - minimum length have to be 8 and contains at least one Lowercase, Uppercase, Number and Symbol')
    .isStrongPassword({
        minLength: 8,
        minLowercase: 1,
        minUppercase: 1,
        minNumbers: 1,
        minSymbols: 1
    }),
 ] ,AuthController.register)

router.post('/login', AuthController.login)

router.get('/verify/:userId/:uniqueString', AuthController.verify)
router.get('/verified', AuthController.verified)

router.post('/sendPasswordReset', AuthController.sendPasswordReset)
router.get('/resetPassword/:userId/:resetString', AuthController.resetPassword)
router.get('/reset', AuthController.reset)

module.exports = router