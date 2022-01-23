import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/admin_bloc.dart';
import 'package:autism101/BlocEvents/admin_bloc_events.dart';
import 'package:autism101/BlocStates/admin_bloc_state.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/admin/admin_home.dart';
import 'package:autism101/Screens/user/home_page.dart';

class MovieScreen extends StatefulWidget {
  final movieName;
  final movieBrief;
  final movieAgeRate;
  final movieActors;
  final movieUrl;
  final movieImageUrl;
  final bool isAdmin;
  MovieScreen({
    required this.movieName,
    required this.movieBrief,
    required this.movieAgeRate,
    required this.movieActors,
    required this.movieUrl,
    required this.movieImageUrl,
    required this.isAdmin,
  });

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late AdminBloc adminBloc;

  @override
  void initState() {
    adminBloc = BlocProvider.of<AdminBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          widget.movieName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      backgroundColor: Colors.black,
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
          } else if (state is DeleteMovieSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminHome(),
              ),
            );
          } else if (state is DeleteMovieErrorState) {
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              Image.network(
                widget.movieImageUrl,
                height: deviceHeight! * 0.7,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: deviceHeight,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.3, 0.9],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: deviceHeight! * 0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.isAdmin
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Watch the movie',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ),
                              ),
                              RawMaterialButton(
                                onPressed: () async {
                                  if (await canLaunch(widget.movieUrl)) {
                                    await launch(widget.movieUrl);
                                  } else {
                                    throw 'Could not launch ${widget.movieUrl}';
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(
                                    CupertinoIcons.play_fill,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                shape: CircleBorder(),
                                fillColor: Colors.blue,
                              ),
                            ],
                          ),
                    K_vSpace,
                    Text(
                      'Brief',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    K_vSpace,
                    Text(
                      widget.movieBrief,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    K_vSpace,
                    SizedBox(
                      width: deviceWidth! * 0.5,
                      child: Container(
                        color: Colors.grey,
                        height: 0.3,
                      ),
                    ),
                    K_vSpace,
                    Text(
                      'Age rate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    K_vSpace,
                    Text(
                      widget.movieAgeRate,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    K_vSpace,
                    SizedBox(
                      width: deviceWidth! * 0.5,
                      child: Container(
                        color: Colors.grey,
                        height: 0.3,
                      ),
                    ),
                    K_vSpace,
                    Text(
                      'Actors',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    K_vSpace,
                    Text(
                      widget.movieActors,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    K_vSpace
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton(
              onPressed: deleteMovie,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 35.0,
              ),
              backgroundColor: Colors.red,
            )
          : null,
    );
  }

  deleteMovie() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Text(
            "Delete",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 21.0,
              height: 1.3,
            ),
          ),
          content: Text(
            "Are you sure? deleting movie will remove this movie permanently from your movies",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18.0,
              height: 1.3,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  height: 1.3,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  height: 1.3,
                ),
              ),
              onPressed: () {
                adminBloc.add(DeleteMovie(movieName: widget.movieName));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
