const user = require('../models/User')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const User = require('../models/User')
const {check, validationResult} = require('express-validator')

const register = (req,res,next) => {

    
    //req.body.password.exists().isLength({min:6}), (req,res) => {
       
    const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({ errors: errors.array() });
        }
        
 

/*
  body("email").isEmail(),
  // password must be at least 5 chars long
  body("password").isLength({ min: 5 }),
  (req, res) => {
    console.log("checking")
    // Finds the validation errors in this request and wraps them in an object with handy functions
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }}
    */
    User.findOne({$or: [{username: req.body.username}, {email: req.body.email}] })
    .then(user => {
            if(user) {
                if( user.email === req.body.email && user.username === req.body.username) {
                    res.json({
                        message: "Username and email already exists"
                    })
                } else if(user.username === req.body.username) {
                    res.json({
                        message: "Username already exists"
                    })
                } else {
                    res.json({
                        message: "Email already exists"
                    })
                }
            } else {
                bcrypt.hash(req.body.password,10, function(err, hashedPass){
                    if(err){
                        res.json({
                            error: err
                        })
                    }
            
                    let user = new User({
                        firstName: req.body.firstName,
                        secondName: req.body.secondName,
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
        })   
}

const login = (req,res,next) => {
    var email = req.body.email
    var password = req.body.password

    User.findOne({email:email})
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
                    let token = jwt.sign({name: user.email}, 'AzQ,PI)0(')
                    res.json({
                        message: 'Login succesful',
                        token: token,
                        id: user.id 
                    })
                }
                else{
                    res.json({
                        message: 'Password is incorrect'
                    })
                }
            })
        }else{
            res.json({
                message: 'Wrong email or password'
            })
        }
    })

}

module.exports = {
    register,
    login
}