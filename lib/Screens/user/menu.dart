import 'package:autism101/Screens/school/school_profile.dart';
import 'package:autism101/Screens/user/view_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_menu_items.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: Container(
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: <Widget>[
          /*User Account Drawer Header*/
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.indigo.shade900,
                  Colors.black,
                ],
                stops: [0.3,0.9]
              ),
              ),
            accountName: TextButton(
              //    onPressed: (null),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileView()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  'Ibrahim Shawki',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            accountEmail: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'Ibrahimshawki@gmail.com',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11.0,
                ),
              ),
            ),
            currentAccountPicture: CircleAvatar(
                radius: 200,
                backgroundColor: Colors.white,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/ibrahim.png',
                      height: 500.0,
                      width: 500.0,
                      fit: BoxFit.cover,
                    ))),
          ),
          MyMenuItems(),
        ],
      ),
    ));
  }
}
