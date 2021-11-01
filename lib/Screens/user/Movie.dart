import 'package:autism101/Screens/user/character_data.dart';
import 'package:autism101/Screens/user/characters_screen.dart';
import 'package:autism101/model/Movie.dart';
import 'package:flutter/material.dart';

import 'MovieScreen.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

List<Movie> movies = [
  Movie('assets/images/movie1.jpg', 'little mn3m', 'About the movie', '15+', 'Ahmed hax'),
  Movie('assets/images/movie2.jpg', 'little mn3m', 'About the movie', '15+', 'Ahmed hax'),
  Movie('assets/images/movie3.jpg', 'little mn3m', 'About the movie', '15+', 'Ahmed hax'),
  Movie('assets/images/movie4.jpg', 'little mn3m', 'About the movie', '15+', 'Ahmed hax'),
  Movie('assets/images/movie5.jpg', 'little mn3m', 'About the movie', '15+', 'Ahmed hax'),
  Movie('assets/images/movie6.jpg', 'little mn3m', 'About the movie', '15+', 'Ahmed hax'),
  Movie('assets/images/movie7.jpg', 'little mn3m', 'About the movie', '15+', 'Ahmed hax'),
  Movie('assets/images/movie8.jpg', 'little mn3m', 'About the movie', '15+', 'Ahmed hax'),
];

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'Movies',
          style: TextStyle(color: Colors.white,fontSize: 20.0),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
      ),
      body: Container(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20),
            padding: EdgeInsets.all(10),
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieScreen(movie: movies[index]),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 0.5, //extend the shadow
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(movies[index].image), fit: BoxFit.cover),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
