import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/admin_bloc.dart';
import 'package:autism101/BlocEvents/admin_bloc_events.dart';
import 'package:autism101/BlocStates/admin_bloc_state.dart';
import 'package:autism101/Screens/admin/admin_home.dart';
import 'package:autism101/flush_bar.dart';

class AddMovieScreen extends StatefulWidget {
  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  TextEditingController _movieNameController = TextEditingController();
  TextEditingController _movieBriefController = TextEditingController();
  TextEditingController _movieAgeRateController = TextEditingController();
  TextEditingController _movieActorsController = TextEditingController();
  TextEditingController _movieUrlController = TextEditingController();
  late AdminBloc adminBloc;
  late File movieImage;
  bool hasMovieImage = false;

  @override
  void dispose() {
    _movieNameController.dispose();
    _movieBriefController.dispose();
    _movieAgeRateController.dispose();
    _movieActorsController.dispose();
    _movieUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    adminBloc = BlocProvider.of<AdminBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Add Movie',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
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
          } else if (state is AddMovieSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminHome(),
              ),
            );
          } else if (state is AddMovieErrorState) {
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
        child: ListView(
          children: [
            //Movie Name Text Field.
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _movieNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Movie Name',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            //Movie Brief Text Field.
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _movieBriefController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Movie Brief',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            //Movie AgeRate Text Field.
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _movieAgeRateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Movie AgeRate',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            //Movie Actors Text Field.
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _movieActorsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Movie Actors',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            //Movie Url Text Field.
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _movieUrlController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Movie Url',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            //Movie Image.
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Container(
                  width: 145.0,
                  height: 35.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5.0),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.lightBlue,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                      ),
                    ),
                    onPressed: chooseFileForMovieImage,
                    child: Text(
                      "Movie Image",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            hasMovieImage
                ? Stack(
                    children: [
                      Center(
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: 170.0,
                          height: 170.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            image: DecorationImage(
                              image: FileImage(
                                movieImage,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5.0,
                        right: 130.0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              hasMovieImage = false;
                            });
                          },
                          child: Icon(
                            Icons.remove_circle,
                            size: 25.0,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Container(
                  width: 145.0,
                  height: 35.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5.0),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.lightBlue,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                      ),
                    ),
                    onPressed: addMovie,
                    child: Text(
                      "Add Movie",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future chooseFileForMovieImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      movieImage = File(pickedFile!.path);
      hasMovieImage = true;
    });
  }

  addMovie() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else if (_movieNameController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Movie name field can't be empty !",
        message: "Please enter movie name.",
        icons: Icons.warning,
      );
    } else if (_movieBriefController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Movie brief field can't be empty !",
        message: "Please enter movie brief.",
        icons: Icons.warning,
      );
    } else if (_movieAgeRateController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Movie ageRate field can't be empty !",
        message: "Please enter movie ageRate.",
        icons: Icons.warning,
      );
    } else if (_movieActorsController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Movie actors field can't be empty !",
        message: "Please enter movie actors.",
        icons: Icons.warning,
      );
    } else if (_movieUrlController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Movie url field can't be empty !",
        message: "Please enter movie url.",
        icons: Icons.warning,
      );
    } else if (hasMovieImage == false) {
      Warning().errorMessage(
        context,
        title: "Movie image can't be empty !",
        message: "Please choose movie image",
        icons: Icons.warning,
      );
    } else {
      adminBloc.add(
        AddMovie(
          movieName: _movieNameController.text,
          movieBrief: _movieBriefController.text,
          movieAgeRate: _movieAgeRateController.text,
          movieActors: _movieActorsController.text,
          movieUrl: _movieUrlController.text,
          movieImage: movieImage,
        ),
      );
    }
  }
}
