const user = require('../models/User')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const User = require('../models/User')
const { check, validationResult } = require('express-validator')

const register = (req, res, next) => {
    const errorFormatter = ({msg}) => {
        return `${msg}`;
      };
    const errors = validationResult(req).formatWith(errorFormatter);
    if (!errors.isEmpty()) {
        return res.status(400).json({ 
            message: errors.array(),     
        });
    }

    User.findOne({ email: req.body.email })
        .then(user => {
            if (user) {
                res.status(409).json({
                    message: 'Email already exists',
                })
            } else {
                bcrypt.hash(req.body.password, 10, function (err, hashedPass) {
                    if (err) {
                        res.status(500).json({
                            message: 'Internal server error'
                        })
                    }

                    let user = new User({
                        email: req.body.email,
                        password: hashedPass
                    })

                    user.save()
                        .then(user => {
                            res.status(201).json({
                                message: 'Account was created successfully',
                            })
                        })
                        .catch(error => {
                            res.status(500).json({
                                message: 'Internal server error',
                            })
                        })
                })
            }
        })
}

const login = (req, res, next) => {
    var email = req.body.email
    var password = req.body.password

    User.findOne({ email })
        .then(user => {
            if (user) {
                bcrypt.compare(password, user.password, function (err, result) {
                    if (err) {
                        res.status(500).json({
                            message: 'Internal server error'
                        })
                    }
                    if (result) {
                        // token doesn't expire 
                        let token = jwt.sign({ name: user.email }, 'AzQ,PI)0(')
                        res.status(200).json({
                            message: 'Successfully logged in',
                            token: token,
                            id: user.id
                        })
                    }
                    else {
                        res.status(401).json({
                            message: 'Invalid credentials',
                        })
                    }
                })
            } else {
                res.status(401).json({
                    message: 'Invalid credentials',
                })
            }
        })
}

module.exports = {
    register,
    login
}