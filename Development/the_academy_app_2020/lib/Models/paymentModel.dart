abstract class PaymentProtocol{
  String productName;
  String productTotalCost;
  String purchaseDate;
  String productSellingCategory;// Premium, AllAccess, Regular
  String productTerm;

}

class PaymentModel extends PaymentProtocol{
  var productName = "Traveling In China 2020";
  var productTotalCost = "999.99" ;
  var purchaseDate = DateTime.now().toString();
  var productSellingCategory = "Premium";
  var productTerm = "Year";

  PaymentModel({
    this.productName,
    this.productTotalCost,
    this.purchaseDate,
    this.productSellingCategory,
    this.productTerm
  });
}

var demoPayments = [
  PaymentModel(
    productName: "Traveling In China 2020",
    productTotalCost: "999.99",
    purchaseDate: DateTime.now().toString(),
    productSellingCategory: "Premium",
    productTerm: "Year",
  ),
  PaymentModel(
    productName: "Traveling In Japan 2020",
    productTotalCost: "49.99",
    purchaseDate: DateTime.now().toString(),
    productSellingCategory: "Regular",
    productTerm: "Year",
  ),
  PaymentModel(
    productName: "Traveling In Italy 2020",
    productTotalCost: "499.99",
    purchaseDate: DateTime.now().toString(),
    productSellingCategory: "All-Access",
    productTerm: "Year",
  ),
  PaymentModel(
    productName: "Traveling In France 2020",
    productTotalCost: "999.99",
    purchaseDate: DateTime.now().toString(),
    productSellingCategory: "Premium",
    productTerm: "Year",
  ),
];


