import 'package:autism101/Constants.dart';
import 'package:autism101/CustomWidgets/NotificationContainer.dart';
import 'package:autism101/CustomWidgets/follower_container.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class PeopleYouMayKnow extends StatefulWidget {
  @override
  _PeopleYouMayKnowState createState() => _PeopleYouMayKnowState();
}

class _PeopleYouMayKnowState extends State<PeopleYouMayKnow> {
  bool pressed = false;
  bool pressGeoON = false;
  bool cmbscritta = false;
  ///notification screen
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
      shape: appBarShape,
      backgroundColor: Colors.white,
      title: Text('People you may know',style: TextStyle(color: Colors.black),),
      leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(
          Icons.arrow_back,
          color: Colors.black
      )),
    ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            FollowerContainer(userImage: 'assets/images/ibrahim.png',userName: 'Ibrahim shawki',),
            FollowerContainer(userImage: 'assets/images/ibrahim.png',userName: 'Ibrahim shawki',),
          ],
        )
    );
  }
}
