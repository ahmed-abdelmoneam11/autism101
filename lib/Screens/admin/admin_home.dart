import 'package:autism101/Borders.dart';
import 'package:autism101/Colors.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/home_page.dart';
import 'package:flutter/material.dart';

class Admin_Home extends StatelessWidget {
  double width = deviceWidth! * 0.45;
  double height = 200;

  @override
  Widget build(BuildContext context) {
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
            child: Icon(
              Icons.logout,
              color: Colors.black,
              size: 30.0,
            ),
          )
        ],
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
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
                      width: width,
                      height: height,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
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
                                    fontWeight: FontWeight.bold),
                              ),
                              //Movies
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
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
                      width: width,
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
                                'Edit Users',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              //Users
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
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
                      width: width,
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
                                'Edit Courses',
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
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
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
                      width: width,
                      height: height,
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
                  ],
                ),
              ],
            ),
            K_vSpace,
            Container(
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
              width: width,
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
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
