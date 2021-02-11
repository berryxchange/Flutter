import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_movie_app/Models/MovieModel.dart';

class HttpHelper {
  final String urlKey = "api_key=8bf78bb879c85337a5ae59cc9fe7f5a3";
  final String urlBase = "https://api.themoviedb.org/3/movie";
  final String urlSearch = "https://api.themoviedb.org/3/search/movie";
  final String urlUpcoming = "/upcoming?";
  final String urlLanguage = "&language=en-US";

  //for searches


  Future<List> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => MovieModel.fromJson(i)).toList();
      return movies;
    }
    else {
      return null;
    }
  }


  Future findMovies(String title) async{
    final String query = "$urlSearch?$urlKey&query=" + title;
    http.Response result = await http.get(query);
    if (result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse["results"];
      List movies = moviesMap.map((i) {
        return MovieModel.fromJson(i);
      }).toList();
      return movies;
    }else{
      return null;
    }
  }
}