/**
* Create your stripe customer
*/
import * as functions from 'firebase-functions';
import { DocumentSnapshot } from "firebase-functions/lib/providers/firestore";
import * as Stripe from "stripe"

const secretKey = functions.config().stripe.key // ensure you have set the configuration
const stripe = new Stripe(StripeConfig.secretKey)

export async function createStripeCustomer(snap: DocumentSnapshot) {

  const customer = {
    email: snap.get('email'),
    phone: snap.get('phoneNumber'),
    name: snap.get('displayName')
  }
    
  const stripeCustomer = await createCustomer(customer)

  if (stripeCustomer) {
    const stripeInfo = {
      customerId: stripeCustomer.id
    }

    try {
      await snap.ref.update({ stripeInfo })
    } catch (err) {
      console.error(err)
    }
  }
}

interface Customer {
  email: string
  displayName: string
  phone: string
  description?: string
  metadata?: any
}

async function createCustomer(customer: Customer) {
  let cust: any = null

  try {
    cust = await stripe.customers.create(customer)
  } catch (err) {
    throw err
  }

  return cust
}