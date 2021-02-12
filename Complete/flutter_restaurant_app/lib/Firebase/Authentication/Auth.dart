import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';



//protocol
abstract class AuthProtocol {
  //#1
  signInWitEmailAndPassword(String email, String password);
  //#2
  createUserWithEmailAndPassword(String email, String password);
  //#3
  sendPasswordResetEmail(String username);
  //#4
  getCurrentUser();
  //#5
  signOut();
}


// Authorization
class AuthCentral implements AuthProtocol {
  static final auth = FirebaseAuth.instance;
  // String host = Platform.isAndroid ? firebase.auth().useEmulator('http://localhost:9099/')


  //#1
  Future<User> signInWitEmailAndPassword(String email, String password) async {
    var thisUser =
    await auth.signInWithEmailAndPassword(email: email, password: password);
    return thisUser.user;
  }

  //#2
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    var thisUser = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return thisUser;
  }

  //#3
  void sendPasswordResetEmail(String username) async {
    var thisUserEmail = await auth.sendPasswordResetEmail(email: username);
    return thisUserEmail;
  }

  //#4
  Future<User> getCurrentUser() async {
    User user = FirebaseAuth.instance.currentUser;
    print("The CurrentUser is: ${user.email}");
    print("The CurrentUser UID is: ${user.uid}");
    return user;
  }

  //#5
  Future<void> signOut() async {
    return await auth.signOut();
  }
}
