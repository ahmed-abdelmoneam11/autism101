import 'package:autism101/Screens/user/skills.dart';
import 'package:flutter/material.dart';
import 'activities.dart';
import 'behav_course.dart';

class Progress extends StatefulWidget {
  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Progress',
          style: TextStyle(color: Colors.black),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 120.0,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Activities(),
                    ),
                  );
                },
                child: Text(
                  'Activities',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              height: 120.0,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(11, 1, 77, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Behavioural(),
                    ),
                  );
                },
                child: Text(
                  'Behavioural',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              height: 120.0,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Skills(),
                    ),
                  );
                },
                child: Text(
                  'Skills',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            // ListTile(
            //   title: Text(
            //     "Activities",
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 18.0,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            //   onTap: () {

            //   },
            // ),
            // SizedBox(
            //   height: 15.0,
            // ),
            // ListTile(
            //   title: Text(
            //     "Behavioural",
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 18.0,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            //   onTap: () {

            //   },
            // ),
            // SizedBox(
            //   height: 15.0,
            // ),
            // ListTile(
            //   title: Text(
            //     "Skills",
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 18.0,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            //   onTap: () {

            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
