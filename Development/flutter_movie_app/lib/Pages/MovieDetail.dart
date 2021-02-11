import 'package:flutter/material.dart';
import 'package:flutter_movie_app/Models/MovieModel.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie;
  final String  imgPath = "https://image.tmdb.org/t/p/w500/";

  MovieDetailPage(this.movie);


  @override
  Widget build(BuildContext context) {
    String path;
    if(movie.posterPath != null){
      path = imgPath + movie.posterPath;
    }else{
      path = "https://image.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg";
    }

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                height: height / 1.5,
                child: Image.network(path),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(movie.overview),
              )
            ],
          ),
        ),
      ),
    );
  }
}
