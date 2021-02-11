import 'package:flutter/material.dart';
import 'package:flutter_recipe_cooking_app/Models/UserModel.dart';

abstract class CommentProtocol {
  UserModel commentingUser;
  var recipeRating;
  var commentDate;
  String commentText;
  int commentLikes;
}

class CommentModel extends CommentProtocol {
  var commentingUser =
      UserModel(userFirstName: "Quinton", userLastName: "Quaye", userImage: "");

  var recipeRating = 4;
  var commentDate = "";
  var commentText = "this recipe was bomb!!";
  var commentLikes = 9;

  CommentModel(
      {this.commentingUser,
      this.recipeRating,
      this.commentText,
      this.commentDate,
      this.commentLikes});
}

var demoComments = [
  CommentModel(
      commentingUser: UserModel(
          userFirstName: "Quinton", userLastName: "Quaye", userImage: ""),
      recipeRating: 4,
      commentDate: "",
      commentText: "This recipe was bomb!!",
      commentLikes: 9),
  CommentModel(
      commentingUser: UserModel(
          userFirstName: "Angela", userLastName: "Bassette", userImage: ""),
      recipeRating: 4,
      commentDate: "",
      commentText: "This recipe was bomb and then some!!",
      commentLikes: 1798),
  CommentModel(
      commentingUser:
          UserModel(userFirstName: "Eva", userLastName: "Snake", userImage: ""),
      recipeRating: 4,
      commentDate: "",
      commentText: "mmm..can I have some more!?",
      commentLikes: 84)
];
