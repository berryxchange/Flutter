import 'dart:async';
import 'dart:io';

class RecipeDB {
  static final RecipeDB _instance = RecipeDB._internal();

  factory RecipeDB() {
    return _instance;
  }

  RecipeDB._internal();
}
