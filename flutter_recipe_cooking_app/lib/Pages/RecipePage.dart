import 'package:flutter/material.dart';
import 'package:flutter_recipe_cooking_app/Models/RecipeModel.dart';
import 'package:flutter_recipe_cooking_app/Widgets/SimilarRecipeWidget.dart';

class RecipePage extends StatefulWidget {
  final RecipeModel thisRecipe;

  RecipePage({this.thisRecipe});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  RecipeModel thisRecipe = RecipeModel();

  @override
  void initState() {
    thisRecipe = widget.thisRecipe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double similarStarSize = 20;
    double similarStarWidth = 2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe App"),
        actions: [
          Icon(
            Icons.favorite_border,
            size: 28,
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: (Column(
              children: [
                Text(
                  thisRecipe.recipeTitle,
                  style: TextStyle(fontSize: 32),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
                          Icons.star,
                          color: Colors.deepOrangeAccent,
                          size: 26,
                        ),
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        child: Icon(
                          Icons.star,
                          color: Colors.deepOrangeAccent,
                          size: 26,
                        ),
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        child: Icon(
                          Icons.star,
                          color: Colors.deepOrangeAccent,
                          size: 26,
                        ),
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        child: Icon(
                          Icons.star,
                          color: Colors.deepOrangeAccent,
                          size: 26,
                        ),
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        child: Icon(
                          Icons.star_border,
                          color: Colors.deepOrangeAccent,
                          size: 26,
                        ),
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "+ 135 reviewed this",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: Colors.white,
                        onPressed: () {
                          //do something
                        },
                        child: Row(
                          children: [
                            Icon(Icons.bookmark_border),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Save")
                          ],
                        ),
                      ),
                      MaterialButton(
                        color: Colors.white,
                        onPressed: () {
                          //do something
                        },
                        child: Row(
                          children: [
                            Icon(Icons.share),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Shared")
                          ],
                        ),
                      ),
                      MaterialButton(
                        color: Colors.white,
                        onPressed: () {
                          //do something
                        },
                        child: Row(
                          children: [
                            Icon(Icons.group),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Feedback")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    color: Colors.black12,
                    height: 260,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "${thisRecipe.recipeImage}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    child: TabBar(
                      labelColor: Colors.deepOrangeAccent,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.deepOrangeAccent,
                      tabs: [
                        Text(
                          "Need To Buy",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Doing",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Similar Recipes",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 600,
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    child: Container(
                                      child: Image.asset(
                                        thisRecipe.recipeCreators[0].userImage,
                                        fit: BoxFit.cover,
                                      ),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Colors.deepOrangeAccent,
                                              width: 1.5),
                                          color: Colors.grey),
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Chef ${thisRecipe.recipeCreators[0].userFirstName}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.group,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("10")
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                child: Text(
                                    "\"A marinade guaranteed to make your chicken breasts tender and juicy! \""),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ingredients",
                                  style: TextStyle(fontSize: 32),
                                ),
                                MaterialButton(
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Icon(Icons.food_bank),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            "${thisRecipe.recipeServingSize} Servings")
                                      ],
                                    ),
                                    onPressed: () {
                                      //do something
                                    })
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                                //shrinkWrap: true,
                                itemCount: thisRecipe.recipeIngredients.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              size: 25,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${thisRecipe.recipeIngredients[index]}",
                                              style: TextStyle(fontSize: 22),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: MaterialButton(
                                onPressed: () {},
                                height: 50,
                                minWidth:
                                    MediaQuery.of(context).size.width - 60,
                                color: Colors.deepOrangeAccent,
                                child: Text(
                                  "Add All To Shopping List",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),

                      //doing

                      Column(
                        children: [
                          Text(
                            "Directions",
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                size: 40,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Prep",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${thisRecipe.recipePrepTime.prepTimeMinutes}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepOrangeAccent),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "min",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Cook",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${thisRecipe.recipePrepTime.cookTimeMinutes}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepOrangeAccent),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "min",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Ready In",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${thisRecipe.recipePrepTime.getReadyTime()}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepOrangeAccent),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "min",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                                //shrinkWrap: true,
                                itemCount: thisRecipe.recipeDirections.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${index + 1}.",
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${thisRecipe.recipeDirections[index]}",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: MaterialButton(
                              onPressed: () {},
                              height: 50,
                              minWidth: MediaQuery.of(context).size.width - 60,
                              color: Colors.deepOrangeAccent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.video_call_outlined,
                                    size: 32,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Watch Video",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),

                      ListView.builder(
                          itemCount: demoRecipes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return RecipePage(
                                      thisRecipe: demoRecipes[index],
                                    );
                                  }));
                                },
                                child: SimilarRecipeWidget(
                                    similarStarSize: similarStarSize,
                                    similarStarWidth: similarStarWidth,
                                    recipe: demoRecipes[index]),
                              ),
                            );
                          }),
                      //similar Recipes
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
