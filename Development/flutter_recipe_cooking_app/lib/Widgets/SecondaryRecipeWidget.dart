import 'package:flutter/material.dart';
import 'package:flutter_recipe_cooking_app/Models/RecipeModel.dart';

class SecondaryRecipeWidget extends StatelessWidget {
  const SecondaryRecipeWidget({
    Key key,
    //@required this.similarStarSize,
    //@required this.similarStarWidth,
    @required this.recipe,
  }) : super(key: key);

  final double similarStarSize = 13;
  final double similarStarWidth = 0;
  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 300,
        width: 190,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(60, 0, 0, 0),
                offset: Offset(0, 5),
                blurRadius: 15,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Column(
            children: [
              Container(
                height: 110,
                width: 190,
                color: Colors.grey,
                child: Image.asset(
                  recipe.recipeImage,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "${recipe.recipeTitle}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: similarStarSize,
                            ),
                            height: similarStarSize,
                            width: similarStarSize,
                          ),
                          SizedBox(
                            width: similarStarWidth,
                          ),
                          Container(
                            child: Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: similarStarSize,
                            ),
                            height: similarStarSize,
                            width: similarStarSize,
                          ),
                          SizedBox(
                            width: similarStarWidth,
                          ),
                          Container(
                            child: Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: similarStarSize,
                            ),
                            height: similarStarSize,
                            width: similarStarSize,
                          ),
                          SizedBox(
                            width: similarStarWidth,
                          ),
                          Container(
                            child: Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: similarStarSize,
                            ),
                            height: similarStarSize,
                            width: similarStarSize,
                          ),
                          SizedBox(
                            width: similarStarWidth,
                          ),
                          Container(
                            child: Icon(
                              Icons.star_border,
                              color: Colors.deepOrangeAccent,
                              size: similarStarSize,
                            ),
                            height: similarStarSize,
                            width: similarStarSize,
                          ),
                          SizedBox(
                            width: similarStarWidth,
                          ),
                          Text(
                            "+ 135",
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 2,
                        color: Colors.deepOrangeAccent,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                "by",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${recipe.recipeCreators[0].userFirstName} ${recipe.recipeCreators[0].userLastName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.timer,
                                size: 16,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                  "${recipe.recipePrepTime.getReadyTime()} min",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.food_bank,
                                size: 16,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text("${recipe.recipeServingSize} Servings",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
