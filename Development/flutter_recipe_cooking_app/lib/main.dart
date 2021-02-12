import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_recipe_cooking_app/Pages/CreationPages/AddARecipePage.dart';
import 'package:flutter_recipe_cooking_app/Pages/RecipeCategoriesPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Recipe App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: RecipeCategoriesPage());
  }
}
