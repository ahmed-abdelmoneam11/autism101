import 'package:autism101/Screens/user/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:autism101/Constants.dart';
import 'package:flutter/services.dart';

class Result extends StatefulWidget {
  final prevDegree;
  Result({this.prevDegree});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shape: appBarShape,
          title: Text(
            "Autism Test Result",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Your Score:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 23.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "${widget.prevDegree}% Indication of Autism",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 23.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: double.infinity,
                  height: 350.0,
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  child: Image.asset(
                    getIndicator(),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your answers suggest ${widget.prevDegree}% indication that you are experiencing.symptoms common among people with autism. However, this quiz is no substitute for a proper diagnois.from a health care professional and we would encourage you to schedule an appointment with your doctor or other mental health professional now.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false,
            );
          },
          label: Text(
            "Finish",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          isExtended: true,
        ),
      ),
      onWillPop: () => exitApp(),
    );
  }

  String getIndicator() {
    if (widget.prevDegree >= 0 && widget.prevDegree <= 35) {
      return 'assets/images/low.jpg';
    } else if (widget.prevDegree >= 36 && widget.prevDegree <= 75) {
      return 'assets/images/medium.jpg';
    } else {
      return 'assets/images/high.jpg';
    }
  }

  exitApp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Text(
            "Exit Autism 101",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 21.0,
              height: 1.3,
            ),
          ),
          content: Text(
            "Do you want to exit ?",
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
                'Yes',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  height: 1.3,
                ),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            TextButton(
              child: Text(
                'No',
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
          ],
        );
      },
    );
  }
}
