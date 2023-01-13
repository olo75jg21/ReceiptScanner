const user = require('../models/User')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const User = require('../models/User')

const UserVerification = require('../models/UserVerification')
const nodemailer = require('nodemailer')
const { v4: uuidv4 } = require('uuid')
require('dotenv').config()
const path = require("path")
const fs = require('fs')
const { promisify } = require('util');
const handlebars = require('handlebars')

const { check, validationResult } = require('express-validator')

var transporter = nodemailer.createTransport({
    host: "smtp.mailtrap.io",
    port: 2525,
    auth: {
        user: process.env.AUTH_EMAIL,
        pass: process.env.AUTH_PASS
    }
});

transporter.verify((error, success) => {
    if (error) {
        console.log(error)
    } else {
        console.log("Ready for messages")
    }
})

// ---------------------------------------------------------
const PasswordReset = require('../models/PasswordReset')
const router = require('../routes/auth')

const sendPasswordReset = (req, res, next) => {
    
    const errorFormatter = ({ msg }) => {
        return `${msg}`;
    };
    const errors = validationResult(req).formatWith(errorFormatter);
    if (!errors.isEmpty()) {
        return res.status(400).json({
            message: errors.array(),
        });
    }

    const { email, newPassword } = req.body

    User.find({ email })
        .then((data) => {
            if (data.length) {
                if (!data[0].verified) {
                    res.status(401).json({
                        message: "Email hasn't been verified yet. Check your inbox"
                    })
                } else {
                    sendResetEmail(data[0], newPassword, res)
                }
            } else {
                res.status(403).json({
                    // No account with the supplied email exists
                    message: 'Wrong credentials'
                })
            }
        })
        .catch((error) => {
            res.status(500).json({
                message: 'Internal server error'
            })
        })
}


const sendResetEmail = ({ _id, email }, newPassword, res) => {
    const resetString = uuidv4() + _id
    const currentUrl = "http://localhost:3000/"

    PasswordReset.deleteMany({ userId: _id })
        .then((result) => {

            const filePath = path.join(__dirname, './../views/verify.html');
            const source = fs.readFileSync(filePath, 'utf-8').toString();
            const template = handlebars.compile(source);
            const replacements = {
                customizedHref: currentUrl + "resetPassword/" + _id + "/" + resetString,
                message: "We heard that you lost the password. Don't worry, use the link below to reset it.",
                buttonText: "Reset Password"
            };
            const htmlToSend = template(replacements);

            const mailOptions = {
                from: process.env.AUTH_EMAIL,
                to: email,
                subject: "Password Reset",
                html: htmlToSend
            }

            bcrypt.hash(resetString, 10)
                .then((hashedResetString) => {

                    bcrypt.hash(newPassword, 10)
                        .then((hashedNewPassword) => {
                            const newPasswordReset = new PasswordReset({
                                userId: _id,
                                resetString: hashedResetString,
                                newPassword: hashedNewPassword,
                                createdAt: Date.now(),
                                expiresAt: Date.now() + 3600000
                            })

                            newPasswordReset.save()
                                .then(() => {
                                    transporter.sendMail(mailOptions)
                                        .then(() => {
                                            res.status(200).json({
                                                message: "Password reset confirmation email was sent"
                                            })
                                        })
                                        .catch((error) => {
                                            res.status(500).json({
                                                message: 'Internal server error'
                                            })
                                        })
                                })
                                .catch((error) => {
                                    res.status(500).json({
                                        message: 'Internal server error'
                                    })
                                })
                        })
                        .catch((error) => {
                            res.status(500).json({
                                message: 'Internal server error'
                            })
                        })
                })
                .catch((error) => {
                    res.status(500).json({
                        message: 'Internal server error'
                    })
                })
        })
        .catch((error) => {
            res.status(500).json({
                message: 'Internal server error'
            })
        })
}

const reset = (req, res, next) => {
    res.status(200).sendFile(path.join(__dirname, "./../views/changedPassword.html"))
}

let messageWrong = 'Something went wrong'

const resetPassword = (req, res, next) => {
    console.log("here")
    let { userId, resetString } = req.params

    PasswordReset.find({ userId })
        .then((result) => {
            if (result.length > 0) {
                const expiresAt = result[0].expiresAt
                const hashedResetString = result[0].resetString
                const hashedNewPassword = result[0].newPassword

                if (expiresAt < Date.now()) {
                    PasswordReset.deleteOne({ userId })
                        .then(() => {
                            let message = 'Password reset link has expired'
                            res.status(302).redirect(`/reset?error=true&message=${message}`)
                        })
                        .catch((error) => {
                            let message = 'Something went wrong'
                            res.status(302).redirect(`/reset?error=true&message=${message}`)
                        })
                } else {
                    bcrypt.compare(resetString, hashedResetString)
                        .then((result) => {
                            if (result) {
                                User.updateOne({ _id: userId }, { password: hashedNewPassword })
                                    .then(() => {
                                        PasswordReset.deleteOne({ userId })
                                            .then(() => {
                                                res.status(200).sendFile(path.join(__dirname, "./../views/changedPassword.html"))
                                            })
                                            .catch((error) => {
                                                res.status(302).redirect(`/reset?error=true&message=${messageWrong}`)
                                            })
                                    })
                                    .catch((error) => {
                                        res.status(302).redirect(`/reset?error=true&message=${messageWrong}`)
                                    })
                            }
                        })
                        .catch((error) => {
                            res.status(302).redirect(`/reset?error=true&message=${messageWrong}`)
                        })
                }
            } else {
                res.status(302).redirect(`/reset?error=true&message=${messageWrong}`)
            }
        })
        .catch((error) => {
            res.status(302).redirect(`/reset?error=true&message=${messageWrong}`)
        })
}

//----------------------------------------------------------

const sendVerificationEmail = ({ _id, email }, res) => {
    const currentUrl = "http://localhost:3000/"
    const uniqueString = uuidv4() + _id

    const filePath = path.join(__dirname, './../views/verify.html');
    const source = fs.readFileSync(filePath, 'utf-8').toString();
    const template = handlebars.compile(source);
    const replacements = {
        customizedHref: currentUrl + "verify/" + _id + "/" + uniqueString,
        message: "We're excited to have you get started. First, you need to confirm your account. Just press the button below.",
        buttonText: "Confirm Account"
    };
    const htmlToSend = template(replacements);

    const mailOptions = {
        from: process.env.AUTH_EMAIL,
        to: email,
        subject: "Verify Your Email",
        html: htmlToSend
    }

    bcrypt.hash(uniqueString, 10)
        .then((hashedUniqueString) => {
            const newVerification = new UserVerification({
                userId: _id,
                uniqueString: hashedUniqueString,
                createdAt: Date.now(),
                expiresAt: Date.now() + 21600000
            })

            newVerification.save()
                .then(() => {
                    transporter.sendMail(mailOptions)
                        .then(() => {
                            res.status(201).json({
                                message: 'Account was created, email confirmation was sent',
                            })
                        })
                })
                .catch((error) => {
                    res.status(500).json({
                        message: 'Internal server error'
                    })
                })
        })
        .catch(() => {
            res.status(500).json({
                message: 'Internal server error'
            })
        })
}

const verify = (req, res, next) => {
    let { userId, uniqueString } = req.params

    UserVerification.find({ userId })
        .then((result) => {
            if (result.length > 0) {
                const { expiresAt } = result[0];
                const hashedUniqueString = result[0].uniqueString

                if (expiresAt < Date.now()) {
                    UserVerification.deleteOne({ userId })
                        .then((result) => {
                            User.deleteOne({ userId })
                                .then(() => {
                                    let message = "Link has expired. Please sign up again."
                                    res.status(302).redirect(`/verified?error=true&message=${message}`)
                                })
                                .catch((error) => {
                                    res.status(302).redirect(`/verified?error=true&message=${messageWrong}`)
                                })
                        })
                        .catch((error) => {
                            res.status(302).redirect(`/verified?error=true&message=${messageWrong}`)
                        })
                } else {
                    bcrypt.compare(uniqueString, hashedUniqueString)
                        .then((result) => {
                            if (result) {
                                User.updateOne({ _id: userId }, { verified: true })
                                    .then(() => {
                                        UserVerification.deleteOne({ userId })
                                            .then(() => {
                                                res.status(200).sendFile(path.join(__dirname, "./../views/verified.html"))
                                            })
                                            .catch((error) => {
                                                res.status(302).redirect(`/verified?error=true&message=${messageWrong}`)
                                            })
                                    })
                                    .catch((error) => {
                                        res.status(302).redirect(`/verified?error=true&message=${messageWrong}`)
                                    })
                            } else {
                                res.status(302).redirect(`/verified?error=true&message=${messageWrong}`)
                            }
                        })
                        .catch((error) => {
                            res.status(302).redirect(`/verified?error=true&message=${messageWrong}`)
                        })
                }

            } else {
                let message = "Account doesn't exist or has been verified already. Please sign up or log in."
                res.status(302).redirect(`/verified?error=true&message=${message}`)
            }
        })
        .catch((error) => {
            res.status(302).redirect(`/verified?error=true&message=${messageWrong}`)
        })
}

const verified = (req, res, next) => {
    res.status(200).sendFile(path.join(__dirname, "./../views/verified.html"))
}

const register = (req, res, next) => {
    const errorFormatter = ({ msg }) => {
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
                        password: hashedPass,
                        verified: false
                    })

                    user.save()
                        .then((result) => {
                            sendVerificationEmail(result, res)
                        })
                        .catch((error) => {
                            console.log(error),
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

                        if (!user.verified) {
                            res.status(400).json({
                                message: "Email hasn't been verified yet. Check your inbox."
                            })
                        } else {
                            // token doesn't expire 
                            let token = jwt.sign({ name: user.email }, 'AzQ,PI)0(')
                            res.status(200).json({
                                message: 'Successfully logged in',
                                token: token,
                                id: user.id
                            })
                        }
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
    login,
    verify,
    verified,
    sendPasswordReset,
    resetPassword,
    reset
}