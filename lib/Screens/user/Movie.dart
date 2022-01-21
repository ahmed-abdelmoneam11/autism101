import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/admin_bloc.dart';
import 'package:autism101/BlocEvents/admin_bloc_events.dart';
import 'package:autism101/BlocStates/admin_bloc_state.dart';
import 'package:autism101/Screens/admin/add_movie_screen.dart';
import 'MovieScreen.dart';

class Movies extends StatefulWidget {
  final bool isAdmin;
  Movies({required this.isAdmin});
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  late AdminBloc adminBloc;
  var movies;
  List moviesList = [];

  @override
  void initState() {
    adminBloc = BlocProvider.of<AdminBloc>(context);
    adminBloc.add(GetMoviesEvent());
    super.initState();
  }

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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Movies',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
      ),
      body: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminLodingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("  Loading...")
                  ],
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is GetMoviesSuccessState) {
            setState(() {
              movies = state.movies;
            });
          } else if (state is GetMoviesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: movies,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "No Movies Yet",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              );
            }
            final moviesData = snapshot.data!.docs;
            for (var movie in moviesData) {
              final name = movie.get('name');
              final brief = movie.get('brief');
              final ageRate = movie.get('ageRate');
              final actors = movie.get('actors');
              final url = movie.get('url');
              final imageUrl = movie.get('imageUrl');
              moviesList.add(
                {
                  'Name': name,
                  'Brief': brief,
                  'AgeRate': ageRate,
                  'Actors': actors,
                  'Url': url,
                  'ImageUrl': imageUrl,
                },
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
              ),
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieScreen(
                          movieName: moviesList[index]['Name'],
                          movieActors: moviesList[index]['Actors'],
                          movieAgeRate: moviesList[index]['AgeRate'],
                          movieBrief: moviesList[index]['Brief'],
                          movieImageUrl: moviesList[index]['ImageUrl'],
                          movieUrl: moviesList[index]['Url'],
                          isAdmin: widget.isAdmin,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 0.5, //extend the shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          moviesList[index]['ImageUrl'],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMovieScreen(),
                  ),
                );
              },
              label: Row(
                children: [
                  Text(
                    "Add Movie",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Icon(
                    Icons.add,
                    size: 30.0,
                  ),
                ],
              ),
              backgroundColor: Colors.deepPurpleAccent,
              isExtended: true,
            )
          : null,
    );
  }
}
