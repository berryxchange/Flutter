import 'package:flutter/material.dart';
import 'package:flutter_movie_app/HTTP/http_helper.dart';
import 'package:flutter_movie_app/Pages/MovieDetail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  final String iconBase = "https://image.tmdb.org/t/p/w92/";
  final String defaultImage = "https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg";
  //Strings
  String result;

  //Icons
  Icon visableIcon = Icon(Icons.search);
  Widget searchBar = Text("Movies");

  //HttpHelper
  HttpHelper helper;

  //ints
  int moviesCount;

  //Lists
  List movies;

  //Futures
  Future initialize() async {
    movies = List();
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  // search
  Future search({String text}) async{
    movies = List();
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    helper = HttpHelper();
    initialize();
    print("Count: ${movies.length}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[
          IconButton(
              icon: visableIcon,
              onPressed: (){
                setState(() {
                  if (this.visableIcon.icon == Icons.search){
                    this.visableIcon = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                      onSubmitted: (String text){
                        search(text: text);
                      },
                    );
                  }else{
                    setState(() {
                      this.visableIcon = Icon(Icons.search);
                      this.searchBar = Text("Movies");
                    });
                  }
                });
              })
        ],
      ),
      body: ListView.builder(
          itemCount: (this.moviesCount == null) ? 0: this.moviesCount,
          itemBuilder: (BuildContext context, int position){
            if (movies[position].posterPath != null){
              image = NetworkImage(
                  iconBase + movies[position].posterPath
              );
            }else{
              image = NetworkImage(defaultImage);
            }

        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: image,
            ),
            title: Text(movies[position].title),
            subtitle: Text(
            "Released: "
                + movies[position].releaseDate
                + " - Vote: "
                + movies[position].voteAverage.toString(),
            ),
            onTap: (){
              MaterialPageRoute route = MaterialPageRoute(builder: (_){
               return  MovieDetailPage(movies[position]);
              });
              Navigator.push(context, route);
            },
          ),
        );
      }),
    );
  }
}
