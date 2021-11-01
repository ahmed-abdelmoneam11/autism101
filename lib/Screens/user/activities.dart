import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  ///Activities Course will be in progress
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 10.0,
              ),

              ///course details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ///the image of the course
                  Image.asset(
                    'assets/images/Course1.png',
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),

                  ///the name of the course
                  SizedBox(
                    width: 150,
                    child: TextButton(
                      onPressed: (null),
                      child: Text(
                        ('Course Name '),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  ///the time of the course
                  Positioned(
                    top: 10,
                    right: 10,
                    child: TextButton(
                      onPressed: null,
                      child: Column(children: <Widget>[
                        Text(
                          ('40:00'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),

              ///space between 2 courses
              SizedBox(
                height: 10.0,
              ),

              ///just for trail
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  /*       ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/images/ibrahim.png',
                              height: 50.0,
                              width: 50.0,
                              fit: BoxFit.cover,
                            )),

                  */
                  Image.asset(
                    'assets/images/Course2.png',
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 150,
                    child: TextButton(
                      onPressed: (null),
                      child: Text(
                        ('Course Name'),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: TextButton(
                      onPressed: null,
                      child: Column(children: <Widget>[
                        Text(
                          ('30:05'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  /*       ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/images/ibrahim.png',
                              height: 50.0,
                              width: 50.0,
                              fit: BoxFit.cover,
                            )),

                  */
                  Image.asset(
                    'assets/images/Course3.png',
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 150,
                    child: TextButton(
                      onPressed: (null),
                      child: Text(
                        ('Course Name'),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: TextButton(
                      onPressed: null,
                      child: Column(children: <Widget>[
                        Text(
                          ('20:30'),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      /*child: Column(
        children: <Widget>[
          Card(
            color: Colors.white,
            shadowColor: Colors.pink,
            elevation: 4,

            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                 /*       ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/images/ibrahim.png',
                              height: 50.0,
                              width: 50.0,
                              fit: BoxFit.cover,
                            )),

                  */
                        Image.asset(
                          'assets/images/ibrahim.png',
                          height: 50.0,
                          width: 50.0,
                          fit: BoxFit.cover,
                        ),
                        TextButton(
                          onPressed: (null),
                          child: Text(
                            ('Course Name'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child:TextButton(
                            onPressed: null,
                            child: Column(children: <Widget>[
                              Text(
                                ('30:05'),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),


              ],
            ),
          ),




        ],
      ),*/
    );
  }
}
