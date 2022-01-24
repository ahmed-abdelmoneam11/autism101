import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/profile_bloc.dart';
import 'package:autism101/BlocEvents/profile_bloc_events.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/Screens/school/school_profile.dart';
import 'package:autism101/Constants.dart';

class ContactWithSchool extends StatefulWidget {
  @override
  _ContactWithSchoolState createState() => _ContactWithSchoolState();
}

class _ContactWithSchoolState extends State<ContactWithSchool> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late ProfileBloc profileBloc;
  List schoolsList = [];
  List<bool> followers = [];
  var schools;

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(
      GetSchoolsEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: Text(
          'Contact With Schools',
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
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLodingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("  Loading...")
                  ],
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is GetSchoolsSuccessState) {
            setState(() {
              schools = state.schools;
            });
          } else if (state is GetSchoolsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: schools,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            final schoolsData = snapshot.data!.docs;
            for (var school in schoolsData) {
              final schoolWebSite = school.get('website');
              final followersCount = school.get('followersCount');
              final eventsCount = school.get('eventsCount');
              final phone = school.get('phone');
              final image = school.get('imageUrl');
              final List schoolFollowers = school.get('followers');
              final schoolDocId = school.id;
              schoolsList.add(
                {
                  "WebSite": schoolWebSite,
                  "SchoolDocId": schoolDocId,
                  "FollowersCount": followersCount,
                  "EventsCount": eventsCount,
                  "Phone": phone,
                  "Image": image,
                },
              );
              schoolFollowers.contains(auth.currentUser!.uid)
                  ? followers.add(true)
                  : followers.add(false);
            }
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  left: 3.0,
                  right: 3.0,
                ),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: shadow,
                  ),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          schoolsList[index]['Image'],
                          height: 90.0,
                          width: 90.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SchoolProfile(
                                webSite: schoolsList[index]['WebSite'],
                                schoolDocID: schoolsList[index]['SchoolDocId'],
                                eventsCount: schoolsList[index]['EventsCount'],
                                followersCount: schoolsList[index]
                                    ['FollowersCount'],
                                phone: schoolsList[index]['Phone'],
                                image: schoolsList[index]['Image'],
                                isSchool: false,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          '${schoolsList[index]['WebSite']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      TextButton(
                        onPressed: () {
                          if (followers[index]) {
                            profileBloc.add(
                              UnFollowSchool(
                                schoolDocID: schoolsList[index]['SchoolDocId'],
                              ),
                            );
                            setState(() {
                              followers[index] = false;
                            });
                          } else {
                            profileBloc.add(
                              FollowSchool(
                                schoolDocID: schoolsList[index]['SchoolDocId'],
                              ),
                            );
                            setState(() {
                              followers[index] = true;
                            });
                          }
                        },
                        child: Text(
                          followers[index] ? 'Following' : 'Follow',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
