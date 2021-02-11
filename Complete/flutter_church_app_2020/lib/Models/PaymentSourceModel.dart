abstract class PaymentSourceProtocol{
  String title;
  String action;
  
}

class PaymentSourceModel extends PaymentSourceProtocol{
  var title;
  var action;
  
  PaymentSourceModel({this.title, this.action});
}