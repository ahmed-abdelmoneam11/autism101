import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/events_bloc.dart';
import 'package:autism101/BlocEvents/events_bloc_events.dart';
import 'package:autism101/BlocStates/events_bloc_state.dart';
import 'package:autism101/flush_bar.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventBioController = TextEditingController();
  TextEditingController _facebookUrlController = TextEditingController();
  late File movieImage;
  late EventsBloc eventBloc;
  bool hasMovieImage = false;

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventBioController.dispose();
    _facebookUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    eventBloc = BlocProvider.of<EventsBloc>(context);
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
          'Add Event',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: BlocListener<EventsBloc, EventsState>(
        listener: (context, state) {
          if (state is EventsLodingState) {
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
          } else if (state is AddEventSuccessState) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AdminHome(),
            //   ),
            // );
          } else if (state is AddEventErrorState) {
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
                controller: _eventNameController,
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
                controller: _eventBioController,
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
                controller: _facebookUrlController,
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
                      "Event Image",
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
                    onPressed: addEvent,
                    child: Text(
                      "Add Event",
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

  addEvent() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else if (_eventNameController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Event name field can't be empty !",
        message: "Please enter event name.",
        icons: Icons.warning,
      );
    } else if (_eventBioController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Event brief field can't be empty !",
        message: "Please enter event bio.",
        icons: Icons.warning,
      );
    } else if (_facebookUrlController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Url field can't be empty !",
        message: "Please enter event url.",
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
      eventBloc.add(
        AddEvent(
          name: _eventNameController.text,
          facebookLink: _facebookUrlController.text,
          bio: _eventBioController.text,
          image: movieImage,
        ),
      );
    }
  }
}
