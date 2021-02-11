const functions = require('firebase-functions');

const admin = require("firebase-admin");
admin.initializeApp();
var stripe = require("stripe")("sk_test_xzFXNe8bFIcvVTNMvKa0oMSZ");


exports.postPayment = functions.https.onRequest(async(req, res) =>{

var customer = req.body.customer;
var amount = req.body.amount;
var currency = req.body.currency;

stripe.charges.create({
  customer: cusomter,
  amount: amount,
  currency : currency
}, function(error, charge){
  if (err){
    console.log(err, req.body)
    res.status(500).end()
  }
})
});