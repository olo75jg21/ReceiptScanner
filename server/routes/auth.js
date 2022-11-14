const express = require('express')
const router = express.Router()

const AuthController = require('../controllers/AuthController')

const { check, validationResult } = require('express-validator');

router.post('/register', [
    check('firstName').isLength({min:3}).withMessage('First name must have at least 3 letters').isAlpha()
    .withMessage('First name must be alphabet letters'),
    check('secondName').isLength({min:3}).withMessage('Second name must have at least 3 letters').isAlpha()
    .withMessage('Second name must be alphabet letters'),
    check('username', 'Login must have at least 3 letters').isLength({min:3}),
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

module.exports = router