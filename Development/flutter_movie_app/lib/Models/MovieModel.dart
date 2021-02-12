import 'dart:ffi';

class MovieModel {
  int id;
  String title;
  var voteAverage;
  String releaseDate;
  String overview;
  String posterPath;

  MovieModel({
    this.id,
    this.title,
    this.voteAverage,
    this.releaseDate,
    this.overview,
    this.posterPath
  });

  MovieModel.fromJson(Map<String, dynamic> parsedJson){
    this.id = parsedJson["id"];
    this.title = parsedJson["title"];
    this.voteAverage = parsedJson["vote_average"];
    this.releaseDate = parsedJson["release_date"];
    this.overview = parsedJson["overview"];
    this.posterPath = parsedJson["poster_path"];
  }
}
