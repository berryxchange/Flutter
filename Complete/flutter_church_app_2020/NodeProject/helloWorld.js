//Do not Edit This Page!!

const express = require('express');
const stripe = require('stripe')('sk_test_xzFXNe8bFIcvVTNMvKa0oMSZ');
const app = express();

app.listen(3000, function () {
  console.log(`Server is running..`);
});



var createCustomer = function (){
	var param = {};
  param.email = "theQ@gmail.com";
  param.name = "Quinton";
  param.description = "from node";
  stripe.customers.create(param, function(err, customer){
    if (err){
      console.log("err: "+err);
    }if (customer){
      console.log("success: "+customer)
    }else{
      console.log("something went wrong")
    }
  })
}

//createCustomer();



var retrieveCustomer = function(){
stripe.customers.retrieve("cus_IeaesVrsZ2M8CJ", function(err, customer){
    if (err){
      console.log("err: "+err);
    }if (customer){
      console.log("success: "+JSON.stringify(customer, null, 2));
    }else{
      console.log("something went wrong")
    }
  });
}

//retrieveCustomer();


var addCardToCustomer = function(){
stripe.customers.createSource("cus_IeaesVrsZ2M8CJ", {source: "tok_1I3HzgCk2hd8UzD70ut8bv1w"}, function(err, card){
    if (err){
      console.log("err: "+err);
    }if (card){
      console.log("success: "+JSON.stringify(card, null, 2));
    }else{
      console.log("something went wrong")
    }
  });
}

//addCardToCustomer();


//chargeCustomerThroughCustomerID();
var chargeCustomerThroughCustomerID = function (){
var param = {};
param.amount = 2000,
param.currency = "usd",
param.description = "First payent",
param.customer = "cus_IeaesVrsZ2M8CJ"

stripe.charges.create(param, function(err, charge){
    if (err){
      console.log("err: "+err);
    }if (charge){
      console.log("success: "+JSON.stringify(charge, null, 2));
    }else{
      console.log("something went wrong")
    }
  });
}


//Create a token for those who dont want to have an account stored on Stripe
//Tokens can only be used once
var createToken = function (){
var param = {};

param.card = {
number: "4242424242424242",
exp_month: 04,
exp_year: 2024,
cvc: "332"
}

stripe.tokens.create(param, function(err, token){
    if (err){
      console.log("err: "+err);
    }if (token){
      console.log("success: "+JSON.stringify(token, null, 2));
    }else{
      console.log("something went wrong")
    }
  });
}

//createToken();

var chargeCustomerThroughTokenID = function (){
var param = {};
param.amount = 2000,
param.currency = "usd",
param.description = "First payment",
param.source = "tok_1I3II8Ck2hd8UzD7sO8rYxG3"

stripe.charges.create(param, function(err, charge){
    if (err){
      console.log("err: "+err);
    }if (charge){
      console.log("success: "+JSON.stringify(charge, null, 2));
    }else{
      console.log("something went wrong")
    }
  });
}

// chargeCustomerThroughTokenID();





var getAllCustomers = function (){

stripe.customers.list({limit: 4}function(err, customers){
    if (err){
      console.log("err: "+err);
    }if (customers){
      console.log("success: "+JSON.stringify(customers.data, null, 2));
    }else{
      console.log("something went wrong")
    }
  });
}

//getAllCustomers();

var deleteCustomer = function (){

stripe.customers.del("cus_IeaesVrsZ2M8CJ", function(err, customer){
    if (err){
      console.log("err: "+err);
    }if (customers){
      console.log("success: "+JSON.stringify(customers.data, null, 2));
    }else{
      console.log("something went wrong")
    }
  });
}

//getAllCustomers();