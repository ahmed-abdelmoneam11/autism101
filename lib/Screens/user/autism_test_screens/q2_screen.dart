import 'package:flutter/material.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/autism_test_screens/q3_screen.dart';
import 'package:autism101/Screens/user/autism_test_screens/q1_screen.dart';

class TestQ2 extends StatefulWidget {
  final prevDegree;
  TestQ2({this.prevDegree});
  @override
  State<TestQ2> createState() => _TestQ2State();
}

class _TestQ2State extends State<TestQ2> {
  bool isChoosen1 = false;
  bool isChoosen2 = false;
  bool isChoosen3 = false;
  bool isChoosen4 = false;
  bool isChoosen5 = false;
  int degree = 0;
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
                child: Text(
                  "Question Two:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 23.0,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Divider(
                thickness: 1.0,
                height: 1.0,
                color: Colors.black,
                indent: 70.0,
                endIndent: 70.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Does your child avoid eye contact?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    //ans1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 12.5,
                          height: 12.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChoosen1 = true;
                              isChoosen2 = false;
                              isChoosen3 = false;
                              isChoosen4 = false;
                              isChoosen5 = false;
                              degree = 2;
                            });
                          },
                          child: Text(
                            "Never",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: isChoosen1 ? Colors.blue : Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    //ans2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 12.5,
                          height: 12.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChoosen2 = true;
                              isChoosen1 = false;
                              isChoosen3 = false;
                              isChoosen4 = false;
                              isChoosen5 = false;
                              degree = 5;
                            });
                          },
                          child: Text(
                            "Rarely",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: isChoosen2 ? Colors.blue : Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    //ans3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 12.5,
                          height: 12.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChoosen3 = true;
                              isChoosen1 = false;
                              isChoosen2 = false;
                              isChoosen4 = false;
                              isChoosen5 = false;
                              degree = 6;
                            });
                          },
                          child: Text(
                            "Sometimes",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: isChoosen3 ? Colors.blue : Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    //ans4
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 12.5,
                          height: 12.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChoosen4 = true;
                              isChoosen1 = false;
                              isChoosen2 = false;
                              isChoosen3 = false;
                              isChoosen5 = false;
                              degree = 8;
                            });
                          },
                          child: Text(
                            "Often",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: isChoosen4 ? Colors.blue : Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    //ans5
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 12.5,
                          height: 12.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChoosen5 = true;
                              isChoosen1 = false;
                              isChoosen2 = false;
                              isChoosen3 = false;
                              isChoosen4 = false;
                              degree = 10;
                            });
                          },
                          child: Text(
                            "Very Often",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: isChoosen5 ? Colors.blue : Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150.0,
              ),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.0,
                        height: 35.0,
                        margin: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5.0),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.grey,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Back",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 75.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 120.0,
                        height: 35.0,
                        margin: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5.0),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.lightBlue,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                                builder: (context) => TestQ3(
                                  prevDegree: widget.prevDegree + degree,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Next",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
