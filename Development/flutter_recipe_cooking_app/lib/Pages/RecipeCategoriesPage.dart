import 'package:flutter/material.dart';
import 'package:flutter_recipe_cooking_app/Models/RecipeModel.dart';
import 'package:flutter_recipe_cooking_app/Pages/CreationPages/AddARecipePage.dart';
import 'package:flutter_recipe_cooking_app/Pages/RecipePage.dart';
import 'package:flutter_recipe_cooking_app/Widgets/RecipeWidget.dart';
import 'package:flutter_recipe_cooking_app/Widgets/SecondaryRecipeWidget.dart';

class RecipeCategoriesPage extends StatefulWidget {
  @override
  _RecipeCategoriesPageState createState() => _RecipeCategoriesPageState();
}

class _RecipeCategoriesPageState extends State<RecipeCategoriesPage> {
  double similarStarSize = 20;
  double similarStarWidth = 2;
  double sectionSpace = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe App"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 28,
            ),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return AddARecipePage();
              }));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "|",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Recipes of the week",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  FlatButton(
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 16, color: Colors.deepOrangeAccent),
                      ),
                      onPressed: () {})
                ],
              ),
              Container(
                height: 175,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: demoRecipes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return RecipePage(
                              thisRecipe: demoRecipes[index],
                            );
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            child: RecipeWidget(
                                similarStarSize: similarStarSize,
                                similarStarWidth: similarStarWidth,
                                recipe: demoRecipes[index]),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: sectionSpace,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "|",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Appetizer",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  FlatButton(
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 16, color: Colors.deepOrangeAccent),
                      ),
                      onPressed: () {})
                ],
              ),
              Container(
                height: 275,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: demoRecipes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return RecipePage(
                              thisRecipe: demoRecipes[index],
                            );
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            child: SecondaryRecipeWidget(
                                //similarStarSize: similarStarSize,
                                //similarStarWidth: similarStarWidth,
                                recipe: demoRecipes[index]),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: sectionSpace,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "|",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Main Dishes",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  FlatButton(
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 16, color: Colors.deepOrangeAccent),
                      ),
                      onPressed: () {})
                ],
              ),
              Container(
                height: 275,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: demoRecipes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return RecipePage(
                              thisRecipe: demoRecipes[index],
                            );
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            child: SecondaryRecipeWidget(
                                //similarStarSize: similarStarSize,
                                //similarStarWidth: similarStarWidth,
                                recipe: demoRecipes[index]),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: sectionSpace,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "|",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Soups",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  FlatButton(
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 16, color: Colors.deepOrangeAccent),
                      ),
                      onPressed: () {})
                ],
              ),
              Container(
                height: 275,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: demoRecipes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return RecipePage(
                              thisRecipe: demoRecipes[index],
                            );
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            child: SecondaryRecipeWidget(
                                //similarStarSize: similarStarSize,
                                //similarStarWidth: similarStarWidth,
                                recipe: demoRecipes[index]),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
