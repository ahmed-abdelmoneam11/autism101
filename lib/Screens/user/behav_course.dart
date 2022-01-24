import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/admin_bloc.dart';
import 'package:autism101/BlocEvents/admin_bloc_events.dart';
import 'package:autism101/BlocStates/admin_bloc_state.dart';

class Behavioural extends StatefulWidget {
  @override
  _BehaviouralState createState() => _BehaviouralState();
}

class _BehaviouralState extends State<Behavioural> {
  late AdminBloc adminBloc;
  List coursesList = [];
  List rate = [];
  var behaviouralCourses;

  @override
  void initState() {
    adminBloc = BlocProvider.of<AdminBloc>(context);
    adminBloc.add(
      GetbehaviouralCoursesEvent(),
    );
    super.initState();
  }

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
          'Behavioural',
          style: TextStyle(color: Colors.black),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is GetbehaviouralCoursesSuccessState) {
            setState(() {
              behaviouralCourses = state.behaviouralCourses;
            });
          }
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: behaviouralCourses,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            final coursesData = snapshot.data!.docs;
            for (var course in coursesData) {
              final name = course.get('courseName');
              final url = course.get('courseUrl');
              coursesList.add(
                {
                  "courseName": name,
                  "courseUrl": url,
                },
              );
              rate.add({
                "star1": false,
                "star2": false,
                "star3": false,
                "star4": false,
                "star5": false,
              });
            }
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(
                  10.0,
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/behavioural.jpg',
                      height: 90.0,
                      width: 90.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Text(
                    '${coursesList[index]['courseName']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            rate[index]['star1'] = !rate[index]['star1'];
                          });
                        },
                        icon: Icon(
                          rate[index]['star1']
                              ? Icons.star
                              : Icons.star_outline,
                          color: rate[index]['star1']
                              ? Colors.yellowAccent
                              : Colors.black,
                        ),
                        iconSize: 30.0,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            rate[index]['star2'] = !rate[index]['star2'];
                          });
                          if (rate[index]['star2']) {
                            setState(() {
                              rate[index]['star1'] = true;
                            });
                          }
                        },
                        icon: Icon(
                          rate[index]['star2']
                              ? Icons.star
                              : Icons.star_outline,
                          color: rate[index]['star2']
                              ? Colors.yellowAccent
                              : Colors.black,
                        ),
                        iconSize: 30.0,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            rate[index]['star3'] = !rate[index]['star3'];
                          });
                          if (rate[index]['star3']) {
                            setState(() {
                              rate[index]['star1'] = true;
                              rate[index]['star2'] = true;
                            });
                          }
                        },
                        icon: Icon(
                          rate[index]['star3']
                              ? Icons.star
                              : Icons.star_outline,
                          color: rate[index]['star3']
                              ? Colors.yellowAccent
                              : Colors.black,
                        ),
                        iconSize: 30.0,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            rate[index]['star4'] = !rate[index]['star4'];
                          });
                          if (rate[index]['star4']) {
                            setState(() {
                              rate[index]['star1'] = true;
                              rate[index]['star2'] = true;
                              rate[index]['star3'] = true;
                            });
                          }
                        },
                        icon: Icon(
                          rate[index]['star4']
                              ? Icons.star
                              : Icons.star_outline,
                          color: rate[index]['star4']
                              ? Colors.yellowAccent
                              : Colors.black,
                        ),
                        iconSize: 30.0,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            rate[index]['star5'] = !rate[index]['star5'];
                          });
                          if (rate[index]['star5']) {
                            setState(() {
                              rate[index]['star1'] = true;
                              rate[index]['star2'] = true;
                              rate[index]['star3'] = true;
                              rate[index]['star4'] = true;
                            });
                          }
                        },
                        icon: Icon(
                          rate[index]['star5']
                              ? Icons.star
                              : Icons.star_outline,
                          color: rate[index]['star5']
                              ? Colors.yellowAccent
                              : Colors.black,
                        ),
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                  onTap: () async {
                    if (await canLaunch(coursesList[index]['courseUrl'])) {
                      await launch(coursesList[index]['courseUrl']);
                    } else {
                      throw 'Could not launch ${coursesList[index]['courseUrl']}';
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
