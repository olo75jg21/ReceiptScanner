const mongoose = require('mongoose')
const Schema = mongoose.Schema

const PasswordResetSchema = new Schema({
   userId: String,
   resetString: String,
   newPassword: String,
   createdAt: Date,
   expiresAt: Date
})

const PasswordResetVerification = mongoose.model('PasswordReset', PasswordResetSchema)
module.exports = PasswordResetVerification