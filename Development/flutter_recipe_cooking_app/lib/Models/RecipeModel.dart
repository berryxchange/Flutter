import 'package:flutter/material.dart';
import 'package:flutter_recipe_cooking_app/Models/CommentModel.dart';
import 'package:flutter_recipe_cooking_app/Models/UserModel.dart';
import 'package:flutter_recipe_cooking_app/Models/CookTimeModel.dart';

abstract class RecipeProtocol {
  var recipeImage;
  List<String> recipeImageGallery;
  String recipeVideo;
  String recipeTitle;
  String recipeDescription;
  String recipeCategory;
  List<String> recipeIngredients;
  int recipeServingSize;
  List<String> recipeDirections;
  CookTimeModel recipePrepTime;
  var recipeRating;
  List<UserModel> recipeCreators;
  bool isLiked;
  List<CommentModel> recipeComments;

  //Functions go here

}

class RecipeModel extends RecipeProtocol {
  var recipeImage = "";
  var recipeImageGallery = List();
  var recipeVideo = "";
  var recipeTitle = "Chicken Fettuccine Alfredo";
  var recipeDescription = "Believe the hype "
      "these were fantastic! I don't have a grill "
      "so for the grill part, I just put them "
      "in the oven at 350 degrees…";

  var recipeCategory = "Pasta";

  List<String> recipeIngredients = [
    "Fettuccine",
    "Alfredo Sauce",
    "Pepper",
    "Salt",
    "Milk"
  ];

  var recipeServingSize = 2;

  List<String> recipeDirections = [
    "Step 1",
    "Step 2",
    "Step 3",
    "Step 4",
    "Step 5"
  ];

  var recipePrepTime = CookTimeModel(
    cookTimeHours: 0,
    cookTimeMinutes: 20,
    prepTimeHours: 0,
    prepTimeMinutes: 15,
    //readyTime: 0
  );

  var recipeRating = "4";

  List<UserModel> recipeCreators = [
    UserModel(userFirstName: "Quinton", userLastName: "Quaye", userImage: "")
  ];

  var isLiked = false;

  var recipeComments = [
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
        commentingUser: UserModel(
            userFirstName: "Eva", userLastName: "Snake", userImage: ""),
        recipeRating: 4,
        commentDate: "",
        commentText: "mmm..can I have some more!?",
        commentLikes: 84)
  ];

  RecipeModel(
      {this.recipeImage,
      this.recipeImageGallery,
      this.recipeVideo,
      this.recipeTitle,
      this.recipeDescription,
      this.recipeCategory,
      this.recipeIngredients,
      this.recipeServingSize,
      this.recipeDirections,
      this.recipePrepTime,
      this.recipeRating,
      this.recipeCreators,
      this.isLiked,
      this.recipeComments});
}

List<RecipeModel> demoRecipes = [
  RecipeModel(
    recipeImage: "Assets/FettuccineAlfredo.jpg",
    recipeImageGallery: [],
    recipeVideo: "",
    recipeTitle: "Chicken Fettuccine Alfredo",
    recipeDescription: "Believe the hype "
        "these were fantastic! I don't have a grill "
        "so for the grill part, I just put them "
        "in the oven at 350 degrees…",
    recipeCategory: "Pasta",
    recipeIngredients: [
      "Fettuccine",
      "Alfredo Sauce",
      "Pepper",
      "Salt",
      "Milk"
    ],
    recipeServingSize: 2,
    recipeDirections: [
      "In a large glass bowl, stir together the vinegar, oil, soy sauce, lime juice, lemon juice.Mix in the garlic, brown sugar, lemon pepper, rosemary, and salt. Place the chicken in the mixture. Cover, and marinate in the refrigerator 8 hours .",
      "Preheat the grill for high heat.",
      "Lightly oil the grill grate. Discard marinade, and place chicken on the grill. Cook 6 to 8 minutes per side, until juices run clear.",
      "In a large glass bowl, stir together the vinegar, oil, soy sauce, lime juice, lemon juice.Mix in the garlic, brown sugar, lemon pepper, rosemary, and salt. Place the chicken in the mixture. Cover, and marinate in the refrigerator 8 hours .",
      "Lightly oil the grill grate. Discard marinade, and place chicken on the grill. Cook 6 to 8 minutes per side, until juices run clear."
    ],
    recipePrepTime: CookTimeModel(
      cookTimeHours: 0,
      cookTimeMinutes: 20,
      prepTimeHours: 0,
      prepTimeMinutes: 15,
      //readyTime: 0
    ),
    recipeRating: "4",
    recipeCreators: [
      UserModel(
          userFirstName: "Quinton",
          userLastName: "Quaye",
          userImage: "Assets/theQ.png")
    ],
    isLiked: false,
    recipeComments: [
      CommentModel(
          commentingUser: UserModel(
              userFirstName: "Quinton",
              userLastName: "Quaye",
              userImage: "Assets/theQ.png"),
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
          commentingUser: UserModel(
              userFirstName: "Eva", userLastName: "Snake", userImage: ""),
          recipeRating: 4,
          commentDate: "",
          commentText: "mmm..can I have some more!?",
          commentLikes: 84)
    ],
  ),
  RecipeModel(
    recipeImage: "Assets/steak.jpg",
    recipeImageGallery: [],
    recipeVideo: "",
    recipeTitle: "Texas Steak",
    recipeDescription: "something tasty from texas about the heavy Steak",
    recipeCategory: "Steak",
    recipeIngredients: ["Steak Meat", "Pepper", "Salt", "Vigor"],
    recipeServingSize: 1,
    recipeDirections: ["Put it on the fire and wait!"],
    recipePrepTime: CookTimeModel(
      cookTimeHours: 0,
      cookTimeMinutes: 30,
      prepTimeHours: 0,
      prepTimeMinutes: 10,
      //readyTime: 0
    ),
    recipeRating: "5",
    recipeCreators: [
      UserModel(
          userFirstName: "Quinton",
          userLastName: "Quaye",
          userImage: "Assets/theQ.png")
    ],
    isLiked: false,
    recipeComments: [
      CommentModel(
          commentingUser: UserModel(
              userFirstName: "Quinton",
              userLastName: "Quaye",
              userImage: "Assets/theQ.png"),
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
          commentingUser: UserModel(
              userFirstName: "Eva", userLastName: "Snake", userImage: ""),
          recipeRating: 4,
          commentDate: "",
          commentText: "mmm..can I have some more!?",
          commentLikes: 84)
    ],
  )
];
