import 'package:flutter/material.dart';
import 'package:flutter_recipe_cooking_app/Models/RecipeModel.dart';

class RecipeWidget extends StatelessWidget {
  const RecipeWidget({
    Key key,
    @required this.similarStarSize,
    @required this.similarStarWidth,
    @required this.recipe,
  }) : super(key: key);

  final double similarStarSize;
  final double similarStarWidth;
  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Container(
        height: 175,
        width: MediaQuery.of(context).size.width - 40,
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
          child: Row(
            children: [
              Container(
                height: 175,
                width: 125,
                color: Colors.grey,
                child: Image.asset(
                  recipe.recipeImage,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${recipe.recipeTitle}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                            height: 20,
                            width: 20,
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
                            height: 20,
                            width: 20,
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
                            height: 20,
                            width: 20,
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
                            height: 20,
                            width: 20,
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
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: similarStarWidth,
                          ),
                          Text(
                            "+ 135 Reviewed",
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
                              Icon(Icons.timer),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                  "${recipe.recipePrepTime.getReadyTime()} min",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ],
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Row(
                            children: [
                              Icon(Icons.food_bank),
                              SizedBox(
                                width: 3,
                              ),
                              Text("${recipe.recipeServingSize} Servings",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.deepOrangeAccent,
                                      width: 1.5),
                                  color: Colors.grey),
                              child: Image.asset(
                                  "${recipe.recipeCreators[0].userImage}"),
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          SizedBox(
                            width: 5,
                          ),
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
                      )
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
