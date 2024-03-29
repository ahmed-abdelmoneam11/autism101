import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/profile_bloc.dart';
import 'package:autism101/BlocEvents/profile_bloc_events.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/Screens/user/chat_screen.dart';
import 'package:autism101/Screens/user/view_profile.dart';
import 'package:autism101/Constants.dart';

class PeopleYouMayKnow extends StatefulWidget {
  @override
  _PeopleYouMayKnowState createState() => _PeopleYouMayKnowState();
}

class _PeopleYouMayKnowState extends State<PeopleYouMayKnow> {
  late ProfileBloc profileBloc;
  List usersList = [];
  List<bool> following = [];
  var users;

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(
      GetPeopleYouMayKnowEvent(),
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
          'People you may know',
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
          } else if (state is GetPeopleYouMayKnowSuccessState) {
            setState(() {
              users = state.users;
            });
          } else if (state is GetPeopleYouMayKnowErrorState) {
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
          stream: users,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            final usersData = snapshot.data!.docs;
            for (var user in usersData) {
              final userFirstName = user.get('firstName');
              final userLastName = user.get('lastName');
              final userPictureUrl = user.get('ProfilePicture');
              final userID = user.get('userID');
              final userDocId = user.id;
              usersList.add(
                {
                  "UserName": '$userFirstName $userLastName',
                  "ProfilePicture": userPictureUrl,
                  "UserDocId": userDocId,
                  "UserID": userID,
                },
              );
              following.add(false);
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
                  padding: EdgeInsets.all(20.0),
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
                            usersList[index]['ProfilePicture'],
                            height: 50.0,
                            width: 50.0,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileView(
                                userDocId: usersList[index]['UserDocId'],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          '${usersList[index]['UserName']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(child: Container()),
                      TextButton(
                        onPressed: () {
                          if (!following[index]) {
                            profileBloc.add(
                              FollowUser(
                                userDocID: usersList[index]['UserDocId'],
                              ),
                            );
                            setState(() {
                              following[index] = true;
                            });
                          }
                        },
                        child: Text(
                          following[index] ? 'Following' : 'Follow',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                userName: usersList[index]['UserName'],
                                userImage: usersList[index]['ProfilePicture'],
                                userDocId: usersList[index]['UserDocId'],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Massage',
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
