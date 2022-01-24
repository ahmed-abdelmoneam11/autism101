import 'package:flutter/material.dart';
import 'package:autism101/Screens/school/add_event_screen.dart';
import 'package:autism101/Constants.dart';

class SchoolProfile extends StatefulWidget {
  final String webSite;
  final String schoolDocID;
  final String phone;
  final String image;
  final int followersCount;
  final int eventsCount;
  final bool isSchool;
  SchoolProfile({
    required this.webSite,
    required this.schoolDocID,
    required this.phone,
    required this.image,
    required this.eventsCount,
    required this.followersCount,
    required this.isSchool,
  });
  @override
  State<SchoolProfile> createState() => _SchoolProfileState();
}

class _SchoolProfileState extends State<SchoolProfile> {
  bool star1 = false;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: Text(
          '${widget.webSite} - Profile',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              K_vSpace,
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          widget.image,
                          height: 90.0,
                          width: 90.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      K_hSpace,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ('${widget.webSite}'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            K_vSpace,
                            Text(
                              ('${widget.phone}'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            K_vSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Posts
                                Column(
                                  children: [
                                    Text(
                                      '${widget.eventsCount}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      ('Events'),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                //Followers
                                Column(
                                  children: [
                                    Text(
                                      '${widget.followersCount}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      ('Followers'),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              K_vSpace,
              widget.isSchool
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEventScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: Colors.blue,
                                  size: 25.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Add Event",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: shadow,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  star1 = !star1;
                                });
                              },
                              icon: Icon(
                                star1 ? Icons.star : Icons.star_outline,
                                color:
                                    star1 ? Colors.yellowAccent : Colors.black,
                              ),
                              iconSize: 30.0,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  star2 = !star2;
                                });
                                if (star2) {
                                  setState(() {
                                    star1 = true;
                                  });
                                }
                              },
                              icon: Icon(
                                star2 ? Icons.star : Icons.star_outline,
                                color:
                                    star2 ? Colors.yellowAccent : Colors.black,
                              ),
                              iconSize: 30.0,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  star3 = !star3;
                                });
                                if (star3) {
                                  setState(() {
                                    star1 = true;
                                    star2 = true;
                                  });
                                }
                              },
                              icon: Icon(
                                star3 ? Icons.star : Icons.star_outline,
                                color:
                                    star3 ? Colors.yellowAccent : Colors.black,
                              ),
                              iconSize: 30.0,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  star4 = !star4;
                                });
                                if (star4) {
                                  setState(() {
                                    star1 = true;
                                    star2 = true;
                                    star3 = true;
                                  });
                                }
                              },
                              icon: Icon(
                                star4 ? Icons.star : Icons.star_outline,
                                color:
                                    star4 ? Colors.yellowAccent : Colors.black,
                              ),
                              iconSize: 30.0,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  star5 = !star5;
                                });
                                if (star5) {
                                  setState(() {
                                    star1 = true;
                                    star2 = true;
                                    star3 = true;
                                    star4 = true;
                                  });
                                }
                              },
                              icon: Icon(
                                star5 ? Icons.star : Icons.star_outline,
                                color:
                                    star5 ? Colors.yellowAccent : Colors.black,
                              ),
                              iconSize: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
