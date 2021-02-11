import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';
import 'package:flutter_restaurant_app/Models/FinanceModel.dart';
import 'package:flutter_restaurant_app/Models/DeliveryAddressModel.dart';
import 'package:flutter_restaurant_app/Globals/FirebaseSingleton.dart';

bool requestedReset = false;
bool isLoggingOut = false;
bool isRemovingUser = false;
int addressIndex = 0;


//User Model
UserModel demoUserOne = UserModel(
  id: "0987654321",
  firstName: "Quinton",
  lastName: "D",
  imageUrl: "myUserImage.png",
  email: "saminoske2@yahoo.com",
  password: "Louvane2",
  phone: "4055555656",
  purchasePoints: 95490,
  cards: demoCardsOnFile,
  deliveryAddresses: demoDeliveryAddresses,
);


//Meal Model
//List<MealModel> currentOrderItems = [];

//popular meals
final List<MealModel> popularMeals = [
  MealModel(
      productName: "Popular Meal 1",
      productPrice: 899,
      productImage: "product1.jpg",
      productDescription: "something about this meal 1",
      productId: "0234567890",
      productDuplicates: 1

  ),
  MealModel(
      productName: "Popular Meal 2",
      productPrice: 899,
      productImage: "product2.jpg",
      productDescription: "something about this meal 2",
      productId: "1224567891",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Popular Meal 3",
      productPrice: 899,
      productImage: "product3.jpg",
      productDescription: "something about this meal 3",
      productId: "2234569992",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Popular Meal 4",
      productPrice: 899,
      productImage: "product4.jpg",
      productDescription: "something about this meal 4",
      productId: "3122334453",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Popular Meal 5",
      productPrice: 899,
      productImage: "product5.jpg",
      productDescription: "something about this meal 5",
      productId: "4988776654",
      productDuplicates: 1
  ),
];


List<MealModel> salads = [
  MealModel(
      productName: "Salad Meal 1",
      productPrice: 899,
      productImage: "product1.jpg",
      productDescription: "something about this meal 1",
      productId: "5234567890",
      productDuplicates: 1

  ),
  MealModel(
      productName: "Salad Meal 2",
      productPrice: 899,
      productImage: "product2.jpg",
      productDescription: "something about this meal 2",
      productId: "6224567891",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Salad Meal 3",
      productPrice: 899,
      productImage: "product3.jpg",
      productDescription: "something about this meal 3",
      productId: "7234569992",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Salad Meal 4",
      productPrice: 899,
      productImage: "product4.jpg",
      productDescription: "something about this meal 4",
      productId: "8122334453",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Salad Meal 5",
      productPrice: 899,
      productImage: "product5.jpg",
      productDescription: "something about this meal 5",
      productId: "9988776654",
      productDuplicates: 1
  ),
];

List<MealModel> soups = [
  MealModel(
      productName: "Soup Meal 1",
      productPrice: 899,
      productImage: "product1.jpg",
      productDescription: "something about this meal 1",
      productId: "11234567890",
      productDuplicates: 1

  ),
  MealModel(
      productName: "Soup Meal 2",
      productPrice: 899,
      productImage: "product2.jpg",
      productDescription: "something about this meal 2",
      productId: "12224567891",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Soup Meal 3",
      productPrice: 899,
      productImage: "product3.jpg",
      productDescription: "something about this meal 3",
      productId: "13234569992",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Soup Meal 4",
      productPrice: 899,
      productImage: "product4.jpg",
      productDescription: "something about this meal 4",
      productId: "14122334453",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Soup Meal 5",
      productPrice: 899,
      productImage: "product5.jpg",
      productDescription: "something about this meal 5",
      productId: "15988776654",
      productDuplicates: 1
  ),
];

List<MealModel> hotMeals = [
  MealModel(
      productName: "Hot Meal 1",
      productPrice: 899,
      productImage: "product1.jpg",
      productDescription: "something about this meal 1",
      productId: "16234567890",
      productDuplicates: 1

  ),
  MealModel(
      productName: "Hot Meal 2",
      productPrice: 899,
      productImage: "product2.jpg",
      productDescription: "something about this meal 2",
      productId: "17224567891",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Hot Meal 3",
      productPrice: 899,
      productImage: "product3.jpg",
      productDescription: "something about this meal 3",
      productId: "18234569992",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Hot Meal 4",
      productPrice: 899,
      productImage: "product4.jpg",
      productDescription: "something about this meal 4",
      productId: "19122334453",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Hot Meal 5",
      productPrice: 899,
      productImage: "product5.jpg",
      productDescription: "something about this meal 5",
      productId: "20988776654",
      productDuplicates: 1
  ),
];

List<MealModel> deserts = [
  MealModel(
      productName: "Desert 1",
      productPrice: 899,
      productImage: "product1.jpg",
      productDescription: "something about this meal 1",
      productId: "21234567890",
      productDuplicates: 1

  ),
  MealModel(
      productName: "Desert 2",
      productPrice: 899,
      productImage: "product2.jpg",
      productDescription: "something about this meal 2",
      productId: "22224567891",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Desert 3",
      productPrice: 899,
      productImage: "product3.jpg",
      productDescription: "something about this meal 3",
      productId: "23234569992",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Desert 4",
      productPrice: 899,
      productImage: "product4.jpg",
      productDescription: "something about this meal 4",
      productId: "24122334453",
      productDuplicates: 1
  ),
  MealModel(
      productName: "Desert 5",
      productPrice: 899,
      productImage: "product5.jpg",
      productDescription: "something about this meal 5",
      productId: "25988776654",
      productDuplicates: 1
  ),
];


/*
List<OrderModel> orderHistory = [
  OrderModel(
    orderItems: [
    ],
    orderTotalCost: 4495,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    productImage: "",
    orderName: "2EJH9J",
    orderStatus: "Completed",
    orderDeliveryCharges: 3,
    orderSubtotal: 899 * 5,
    orderTax: 0,
    deliveryRating: 0,
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
  ),

  OrderModel(
    orderItems: [
    ],
    orderTotalCost: 4495,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    productImage: "",
    orderName: "66JH9B",
    orderStatus: "Completed",
    orderDeliveryCharges: 3,
    orderSubtotal: 899 * 5,
    orderTax: 0,
    deliveryRating: 0,
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
  ),

  OrderModel(
    orderItems: [
    ],
    orderTotalCost: 4495,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    productImage: "",
    orderName: "37KH9J",
    orderStatus: "Cancelled",
    orderDeliveryCharges: 3,
    orderSubtotal: 899 * 5,
    orderTax: 0,
    deliveryRating: 0,
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
  ),

  OrderModel(
    orderItems: [
    ],
    orderTotalCost: 4495,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    productImage: "",
    orderName: "2EJPP1",
    orderStatus: "Refunded",
    orderDeliveryCharges: 3,
    orderSubtotal: 899 * 5,
    orderTax: 0,
    deliveryRating: 0,
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
  ),
];


 */

// cards on hand
List<CreditCardModel> demoCardsOnFile = [
  CreditCardModel(
    firstName: "Quinton",
    lastName: "D",
    cardNumber: "4242424242424242",
    expiryDate: "04/24",
    expiryMonth: 04,
    expiryYear: 24,
    cardHolderName: "Quinton D",
    cvvCode: "423",
    showBackView: false,
  ),
  CreditCardModel(
    firstName: "Danny",
    lastName: "D",
    cardNumber: "6011111111111117",
    expiryDate: "06/25",
    expiryMonth: 04,
    expiryYear: 24,
    cardHolderName: "Danny D",
    cvvCode: "123",
    showBackView: false,
  ),
  CreditCardModel(
    firstName: "Ouival",
    lastName: "Oui",
    cardNumber: "6200000000000005",
    expiryDate: "01/21",
    expiryMonth: 04,
    expiryYear: 24,
    cardHolderName: "Ouival Oui",
    cvvCode: "123",
    showBackView: false,
  ),
];
//--------------

//Delivery Addresses
List<DeliveryAddressModel> demoDeliveryAddresses = [
  DeliveryAddressModel(
    address: "7708 N.W. 84th st",
    city: "Oklahoma City",
    state: "Oklahoma",
    zip: "73132",
    apartmentNumber: "8A",
  ),
  DeliveryAddressModel(
    address: "15357 Chippewa st",
    city: "Buchanan",
    state: "Michigan",
    zip: "49107",
    apartmentNumber: "",
  ),
  DeliveryAddressModel(
    address: "1000 Stadium Drive",
    city: "Kalamazoo",
    state: "Michigan",
    zip: "49008",
    apartmentNumber: "",
  ),
  DeliveryAddressModel(
    address: "1801 N.E. 19th st",
    city: "Oklahoma City",
    state: "Oklahoma",
    zip: "73111",
    apartmentNumber: "",
  ),
];