import 'package:flutter/material.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/autism_test_screens/q1_screen.dart';

class StartTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: appBarShape,
        title: Text(
          "Autism Test",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 320.0,
            padding: EdgeInsets.all(
              10.0,
            ),
            child: Image.asset(
              'assets/images/e60199608abcaa780b0f8f08bf09d97e.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 60.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Does my child have autism? This short quiz can help parents assess whether your child is experiencing symptoms common among children with autism",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 80.0,
          ),
          Center(
            child: Container(
              width: 140.0,
              height: 40.0,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => ParentAccount(),
                      builder: (context) => TestQ1(),
                    ),
                  );
                },
                child: Text(
                  "Start",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
