import 'package:autism101/Screens/user/skills.dart';
import 'package:flutter/material.dart';

import 'activities.dart';
import 'behav_course.dart';

class Progress extends StatefulWidget {
  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  ///progress screen
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () => Navigator.pop(context)),
          title: Text('Progress',style: TextStyle(color: Colors.black),),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
          bottom: TabBar(
            ///the tab bar where you can navigate between the
            tabs: [
              Tab(icon: Text('Behavioural',style: TextStyle(color: Colors.black))),
              Tab(icon: Text('Activities',style: TextStyle(color: Colors.black))),
              Tab(icon: Text('Skills',style: TextStyle(color: Colors.black))),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ///Behavioural will be call here
            Center(
              child: ListView(
                children: <Widget>[
                  Behavioural(),
                ],
              ),
            ),

            ///Activities will be call here
            Center(
              child: ListView(
                children: <Widget>[
                  Activities(),
                ],
              ),
            ),

            ///Skills will be call here
            Center(
              child: ListView(
                children: <Widget>[
                  Skills(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
