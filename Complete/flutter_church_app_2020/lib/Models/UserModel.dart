import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_church_app_2020/Models/UserAddressModel.dart';
import 'package:flutter_church_app_2020/Models/PaymentOrderModel.dart';
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';

abstract class ChurchUserProtocol {
  String key;
  String userFirstName;
  String userLastName;
  String userEmail;
  String userRole;
  String userImageUrl;
  String userName;
  String password;
  //List groupInterests = [];
  //List socialPosts = [];
  //List prayerPosts = [];
  //List prayerAgreements = [];
  //List socialLikes = [];
  //List pastoralLikes = [];
  bool chatNotification = false;
  bool mainNotification = false;
  bool mediaNotification = false;
  bool pastoralNotification = false;
  bool prayerNotification = false;
  bool socialNotification = false;
  bool liveStreamNotification = false;
  bool isAdmin;
  String userUID;
  bool isViewedIntroOnboarding = false;
  bool isViewedAdminOnboarding = false;
  bool isViewedPrayerOnboarding = false;
  bool isViewedProfileOnboarding = false;
  //List<CreditCardModel> cards;
  List<UserAddressModel> userAddresses;
  String token;
  String paymentId;

  addAddressToList(UserAddressProtocol address) {
    this.userAddresses.add(address);
  }

  removeAddressFromList(UserAddressProtocol address) {
    this.userAddresses.remove(address);
  }

  addPaymentToHistory(
      {BuildContext context,
      PaymentOrderModel paidOrder,
      ChurchUserModel thisUser,
      String paymentType}) {
    setUserOrdersToFBCurrentHistory(context, paidOrder, thisUser, paymentType);
  }

  //firebase Post
  void setUserOrdersToFBCurrentHistory(
      BuildContext context,
      PaymentOrderModel thisNewOrder,
      ChurchUserModel thisUser,
      String paymentType) async {
    //create FB Singleton Instance to use its properties
    ChurchDB churchDB = ChurchDB();

    thisNewOrder.paymentType = paymentType;

    // try the singleton for user data
    setCurrentOrder(
        context: context,
        thisNewOrder: thisNewOrder,
        churchDB: churchDB,
        thisUser: thisUser,
        paymentType: paymentType);
  }

  setCurrentOrder(
      {BuildContext context,
      PaymentOrderModel thisNewOrder,
      ChurchDB churchDB,
      ChurchUserModel thisUser,
      String paymentType}) {
    try {
      //check if user UID exists
      if (thisUser.userUID != null) {
        print("all good to go sending to FB! the UID: $userUID");

        //Then, wait till this post of the incoming order
        // as JSON data Dictionary is finished
        churchDB.launchOrderPath(
            context: context,
            thisUser: this,
            thisOrder: thisNewOrder,
            paymentType: paymentType,
            actionToDo: "create");

        //---------------

      } else {
        print("this user is not in the database...");
      }
      //end of if statement
    } catch (error) {
      print("something went wrong: $error");
    }
  }
//end of protocol
}

class ChurchUserModel extends ChurchUserProtocol {
  String key;
  String userFirstName = "";
  String userLastName = "";
  String userEmail = "";
  String userRole = "";
  String userImageUrl = "";
  String userName = "";
  String password = "";
  //List groupInterests = [];
  //List socialPosts = [];
  //List prayerPosts = [];
  //List prayerAgreements = [];
  //List socialLikes = [];
  //List pastoralLikes = [];
  bool chatNotification = false;
  bool mainNotification = false;
  bool mediaNotification = false;
  bool pastoralNotification = false;
  bool prayerNotification = false;
  bool socialNotification = false;
  bool liveStreamNotification = false;
  bool isAdmin = false;
  String userUID = "";
  bool isViewedIntroOnboarding = false;
  bool isViewedAdminOnboarding = false;
  bool isViewedPrayerOnboarding = false;
  bool isViewedProfileOnboarding = false;
  List<UserAddressModel> userAddresses = List();
  String token;
  String paymentId;

  ChurchUserModel(
      {this.userFirstName,
      this.userLastName,
      this.userEmail,
      this.userRole,
      this.userImageUrl,
      this.userName,
      this.password,
      this.chatNotification,
      this.mainNotification,
      this.mediaNotification,
      this.pastoralNotification,
      this.prayerNotification,
      this.socialNotification,
      this.liveStreamNotification,
      this.isAdmin,
      this.userUID,
      this.isViewedIntroOnboarding,
      this.isViewedAdminOnboarding,
      this.isViewedPrayerOnboarding,
      this.isViewedProfileOnboarding,
      this.userAddresses,
      this.token,
      this.paymentId});

  ChurchUserModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        userFirstName = snapshot.value["firstname"],
        userLastName = snapshot.value["lastname"],
        userEmail = snapshot.value["email"],
        userRole = snapshot.value["userRole"],
        userImageUrl = snapshot.value["userImageUrl"],
        userName = snapshot.value["username"],
        password = snapshot.value["password"],
        chatNotification = snapshot.value["chatNotification"],
        mainNotification = snapshot.value["mainNotification"],
        mediaNotification = snapshot.value["mediaNotification"],
        pastoralNotification = snapshot.value["pastoralBlogNotification"],
        prayerNotification = snapshot.value["prayerNotification"],
        socialNotification = snapshot.value["socialNotification"],
        liveStreamNotification = snapshot.value["liveStreamNotification"],
        isAdmin = snapshot.value["isAdmin"],
        userUID = snapshot.value["userUID"],
        //isViewedIntroOnboarding = snapshot.value["isViewedIntroOnboarding"],
        //isViewedAdminOnboarding = snapshot.value["isViewedAdminOnboarding"],
        //isViewedPrayerOnboarding = snapshot.value["isViewedPrayerOnboarding"],
        //isViewedProfileOnboarding = snapshot.value["isViewedProfileOnboarding"],
        userAddresses = snapshot.value["userAddresses"],
        token = snapshot.value["token"],
        paymentId = snapshot.value["paymentId"];

  toJson() {
    return {
      "firstname": userFirstName,
      "lastname": userLastName,
      "email": userEmail,
      "role": userRole,
      "userImageUrl": userImageUrl,
      "username": userName,
      "password": password,
      "chatNotification": chatNotification,
      "mainNotification": mainNotification,
      "mediaNotification": mediaNotification,
      "pastoralBlogNotification": pastoralNotification,
      "prayerNotification": prayerNotification,
      "socialNotification": socialNotification,
      "liveStreamNotification":liveStreamNotification,
      "isAdmin": isAdmin,
      "userUID": userUID,
      "isViewedIntroOnboarding": isViewedIntroOnboarding,
      "isViewedAdminOnboarding": isViewedAdminOnboarding,
      "isViewedPrayerOnboarding": isViewedPrayerOnboarding,
      "isViewedProfileOnboarding": isViewedProfileOnboarding,
      "token": token,
      "paymentId": paymentId
    };
  }
}
