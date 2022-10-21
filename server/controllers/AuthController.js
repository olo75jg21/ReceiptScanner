const user = require('../models/User')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const User = require('../models/User')

const register = (req,res,next) => {
    bcrypt.hash(req.body.password,10, function(err, hashedPass){
        if(err){
            res.json({
                error: err
            })
        }

        let user = new User({
            username: req.body.username,
            email: req.body.email,
            password: hashedPass
        })
    
        user.save()
        .then(user=> {
            res.json({
                message: 'User Added Successfully'
            })
        })
        .catch(error => {
            res.json({
                message: 'An error occured'
            })
        })
    })
}

const login = (req,res,next) => {
    var username = req.body.username
    var password = req.body.password

    User.findOne({$or: [{username: username}, {email:username}] })
    .then( user => {
        if(user) {
            bcrypt.compare(password, user.password, function(err,result){
                if(err){
                    res.json({
                        error: err
                    })
                }
                if(result){
                    // token doesn't expire 
                    let token = jwt.sign({name: user.username}, 'secretValue')
                    res.json({
                        message: 'Login succesful',
                        token: token,
                        id: user.id 
                    })
                }
                else{
                    res.json({
                        message: 'Password doesn not match'
                    })
                }
            })
        }else{
            res.json({
                message: 'No user found'
            })
        }
    })

}

module.exports = {
    register,
    login
}