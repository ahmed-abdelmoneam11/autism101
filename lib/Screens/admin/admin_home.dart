import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/auth_bloc.dart';
import 'package:autism101/BlocEvents/auth_bloc_events.dart';
import 'package:autism101/BlocStates/auth_bloc_state.dart';
import 'package:autism101/Borders.dart';
import 'package:autism101/Colors.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/flush_bar.dart';
import 'package:autism101/Screens/LoginForm.dart';
import 'package:autism101/Screens/user/Movie.dart';
import 'package:autism101/Screens/user/home_page.dart';
import 'package:autism101/Screens/admin/delete_user_screen.dart';
import 'package:autism101/Screens/admin/topic_screen.dart';
import 'package:autism101/Screens/user/Inspiring.dart';
import 'package:autism101/Screens/admin/verify_school.dart';

class AdminHome extends StatefulWidget {
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(fontSize: 20.0),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: signOut,
              icon: Icon(Icons.logout),
              color: Colors.black,
              iconSize: 30.0,
            ),
          )
        ],
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LodingState) {
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
          } else if (state is SignOutSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Loginform(),
              ),
              (route) => false,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      //Edit Movies.
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Movies(
                                isAdmin: true,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          //Main Container
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(K_mainRadius),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [K_mainColor, K_blueColor],
                              stops: [0.1, 1],
                            ),
                          ),
                          width: deviceWidth! * 0.45,
                          height: 200.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 10.0),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                //Column inside the container
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Edit Movies',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //Movies
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      //Edit Users
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FindUser(),
                            ),
                          );
                        },
                        child: Container(
                          //Main Container
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(K_mainRadius),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [K_blueColor, K_moveColor],
                              stops: [0.1, 1],
                            ),
                          ),
                          width: deviceWidth! * 0.45,
                          height: 154,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 10.0),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                //Column inside the container
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Delete Users',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifySchools(),
                            ),
                          );
                        },
                        child: Container(
                          //Main Container
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(K_mainRadius),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [K_moveColor, K_blueColor],
                              stops: [0.1, 1],
                            ),
                          ),
                          width: deviceWidth! * 0.45,
                          height: 154,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 10.0),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                //Column inside the container
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Verify School',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Topics(),
                            ),
                          );
                        },
                        child: Container(
                          //Main Container
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(K_mainRadius),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [K_blueColor, K_mainColor],
                              stops: [0.1, 1],
                            ),
                          ),
                          width: deviceWidth! * 0.45,
                          height: 200.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 10.0),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                //Column inside the container
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Edit Topics',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              K_vSpace,
              //Edit Inspiring.
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Inspiring(
                        isAdmin: true,
                      ),
                    ),
                  );
                },
                child: Container(
                  //Main Container
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(K_mainRadius),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [K_blueColor, K_moveColor],
                      stops: [0.1, 1],
                    ),
                  ),
                  width: deviceWidth! * 0.45,
                  height: 154,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        //Column inside the container
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Edit Inspiring People',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signOut() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              elevation: 1.0,
              title: Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                  height: 1.3,
                ),
              ),
              content: Text(
                "Confirm Sign Out",
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
                    'Confirm',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      height: 1.3,
                    ),
                  ),
                  onPressed: () {
                    authBloc.add(SignOutButtonPressed());
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }
}
