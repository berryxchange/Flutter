import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_recipe_cooking_app/Firebase/RecipeDB.dart';
import 'package:flutter_recipe_cooking_app/Models/RecipeModel.dart';
import 'package:flutter_recipe_cooking_app/Models/CookTimeModel.dart';
import 'package:flutter_recipe_cooking_app/Models/UserModel.dart';
import 'package:flutter_recipe_cooking_app/Models/CommentModel.dart';
import 'package:flutter_recipe_cooking_app/Pages/RecipeCategoriesPage.dart';

class AddARecipePage extends StatefulWidget {
  @override
  _AddARecipePageState createState() => _AddARecipePageState();
}

class _AddARecipePageState extends State<AddARecipePage>
    with TickerProviderStateMixin {
  RecipeDB recipeDB;

  //the form
  final _overviewFormKey = GlobalKey<FormState>();
  final _ingredientsFormKey = GlobalKey<FormState>();
  final _directionsFormKey = GlobalKey<FormState>();

  var thisCurrentUser =
      UserModel(userFirstName: "", userLastName: "", userImage: "");

  var tabBarIndex = 0;

  var thisRecipe = RecipeModel(
    recipeImage: "",
    recipeImageGallery: [],
    recipeVideo: "",
    recipeTitle: "",
    recipeDescription: "",
    recipeCategory: "",
    recipeIngredients: [],
    recipeServingSize: 1,
    recipeDirections: [],
    recipePrepTime: null,
    recipeRating: "",
    recipeCreators: [],
    isLiked: false,
    recipeComments: [],
  );

  var thisRecipeCookTime = CookTimeModel(
    cookTimeHours: 0,
    cookTimeMinutes: 0,
    prepTimeHours: 0,
    prepTimeMinutes: 0,
  );

  List<Widget> ingrdientsList = [];

  var myTabs = [
    Text(
      "Recipe Overview",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16),
    ),
    Text(
      "Recipe Ingredients",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16),
    ),
    Text(
      "Recipe Directions",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16),
    ),
  ];

  TabController _tabController;

  void handleSubmit() {
    final FormState overviewForm = _overviewFormKey.currentState;
    final FormState ingredientForm = _ingredientsFormKey.currentState;
    final FormState directionsForm = _directionsFormKey.currentState;

    if (overviewForm.validate() &&
        ingredientForm.validate() &&
        directionsForm.validate()) {
      overviewForm.save();
      overviewForm.reset();

      ingredientForm.save();
      ingredientForm.reset();

      directionsForm.save();
      directionsForm.reset();

      //do database functions here....
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(vsync: this, length: myTabs.length);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DefaultTabController(
        initialIndex: tabBarIndex,
        length: 3,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                print("Adding a picture");
              },
              child: Container(
                color: Colors.black12,
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 75,
                        color: Colors.black26,
                      ),
                      Text(
                        "Add your photo",
                        style: TextStyle(fontSize: 20, color: Colors.black38),
                      ),
                    ])),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.deepOrangeAccent,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.deepOrangeAccent,
                    tabs: myTabs,
                  ),
                ),
              ),
            ),
            Container(
              //height: MediaQuery.of(context).size.height,
              child: Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    //#1
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Form(
                            key: _overviewFormKey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Recipe Name",
                                      labelStyle: TextStyle(
                                          fontSize: 24, color: Colors.grey),
                                    ),
                                    onSaved: (value) {
                                      setState(() {
                                        thisRecipe.recipeTitle = value;
                                      });
                                      print(thisRecipe.recipeTitle);
                                      return null;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a title';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(60, 0, 0, 0),
                                          offset: Offset(0, 5),
                                          blurRadius: 15,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: "Recipe Description",
                                            labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none),
                                        onSaved: (value) {
                                          setState(() {
                                            thisRecipe.recipeTitle = value;
                                          });
                                          print(thisRecipe.recipeTitle);
                                          return null;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter a title';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Serving Size",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      OutlineButton(
                                          onPressed: () {},
                                          child: Row(
                                            children: [
                                              Icon(Icons.food_bank),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${thisRecipe.recipeServingSize}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors
                                                        .deepOrangeAccent),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("Servings",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey))
                                            ],
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          _tabController.animateTo(
                                              _tabController.index + 1);
                                        });
                                      },
                                      height: 50,
                                      minWidth:
                                          MediaQuery.of(context).size.width -
                                              60,
                                      color: Colors.deepOrangeAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Recipe Ingredients",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 24,
                                            color: Colors.amber,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //#2
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Form(
                            key: _ingredientsFormKey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Recipe Ingredients",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          _tabController.animateTo(
                                              _tabController.index + 1);
                                        });
                                      },
                                      height: 50,
                                      minWidth:
                                          MediaQuery.of(context).size.width -
                                              60,
                                      color: Colors.deepOrangeAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Recipe Directions",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 24,
                                            color: Colors.amber,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //#3
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Form(
                            key: _directionsFormKey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Recipe Directions",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        print("Completed");
                                        Navigator.pop(context);
                                      },
                                      height: 50,
                                      minWidth:
                                          MediaQuery.of(context).size.width -
                                              60,
                                      color: Colors.deepOrangeAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Complete Recipe",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
