import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/Blocs/profile_bloc.dart';
import 'package:autism101/BlocEvents/profile_bloc_events.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/Screens/school/add_event_screen.dart';
import 'package:autism101/Blocs/auth_bloc.dart';
import 'package:autism101/BlocEvents/auth_bloc_events.dart';
import 'package:autism101/BlocStates/auth_bloc_state.dart';
import 'package:autism101/Screens/LoginForm.dart';
import 'package:autism101/Screens/user/view_profile.dart';
import 'package:autism101/Screens/user/profile_user.dart';
import 'package:autism101/Screens/school/school_profile.dart';
import 'package:autism101/Constants.dart';

class SchoolHomePage extends StatefulWidget {
  @override
  _SchoolHomePageState createState() => _SchoolHomePageState();
}

class _SchoolHomePageState extends State<SchoolHomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late ProfileBloc profileBloc;
  late PostsBloc postsBloc;
  late AuthBloc authBloc;
  String webSite = '';
  String docID = '';
  String phone = '';
  int followersCount = 0;
  int eventsCount = 0;
  String profilePictureUrl =
      'https://firebasestorage.googleapis.com/v0/b/autism101-4d85b.appspot.com/o/demoUserImage.jpg?alt=media&token=1bbf3bd7-017a-4299-becb-8228a29d796e';
  var posts;
  List postsList = [];

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
    profileBloc.add(
      GetSchoolDataEvent(),
    );
    postsBloc.add(
      GetTimeLinePosts(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SchoolProfile(
                  webSite: webSite,
                  schoolDocID: docID,
                  eventsCount: eventsCount,
                  followersCount: followersCount,
                  phone: phone,
                  image: profilePictureUrl,
                  isSchool: true,
                ),
              ),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profilePictureUrl),
                radius: 20.0,
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                webSite,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: signOut,
              icon: Icon(Icons.logout),
              color: Colors.black,
              iconSize: 30.0,
            ),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is GetSchoolDataSuccessState) {
                setState(() {
                  webSite = state.webSite;
                  docID = state.docID;
                  profilePictureUrl = state.image;
                  followersCount = state.followersCount;
                  eventsCount = state.eventsCount;
                  phone = state.phone;
                });
              }
            },
          ),
          BlocListener<PostsBloc, PostsState>(
            listener: (context, state) {
              if (state is GetTimeLinePostsSuccessState) {
                setState(() {
                  posts = state.posts;
                });
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LodingState) {
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
              } else if (state is SignOutSuccessState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Loginform(),
                  ),
                  (route) => false,
                );
              }
            },
          )
        ],
        child: StreamBuilder<QuerySnapshot>(
          stream: posts,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlue,
                ),
              );
            }
            final postsData = snapshot.data!.docs;
            for (var post in postsData) {
              final postContent = post.get('post');
              final postImageUrl = post.get('postImageUrl');
              final userFirstName = post.get('userFirstName');
              final userLastName = post.get('userLastName');
              final userPictureUrl = post.get('userPictureUrl');
              final userDocId = post.get('userDocID');
              final userID = post.get('userID');
              final postImageFlag = post.get('postHasImage');
              postImageFlag
                  ? postsList.add(
                      {
                        "post": postContent,
                        "postImage": postImageUrl,
                        "userName": '$userFirstName $userLastName',
                        "userPicture": userPictureUrl,
                        "userDocId": userDocId,
                        "userID": userID,
                        "postImageFlag": postImageFlag,
                      },
                    )
                  : postsList.add(
                      {
                        "post": postContent,
                        "postImage": postImageUrl,
                        "userName": '$userFirstName $userLastName',
                        "userPicture": userPictureUrl,
                        "userDocId": userDocId,
                        "userID": userID,
                        "postImageFlag": postImageFlag,
                      },
                    );
            }
            return snapshot.hasData
                ? Container(
                    height: 700.0,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Container(
                            width: 380,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadow,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: [
                                      //the inf of the owner of the post
                                      Row(
                                        children: <Widget>[
                                          //image of the owner of the post
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              postsList[index]['userPicture'],
                                              height: 50.0,
                                              width: 50.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          //the name of the user
                                          TextButton(
                                            onPressed: () {
                                              postsList[index]['userID'] ==
                                                      auth.currentUser!.uid
                                                  ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyHomePage(),
                                                      ),
                                                    )
                                                  : Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileView(
                                                          userDocId:
                                                              postsList[index]
                                                                  ['userDocId'],
                                                        ),
                                                      ),
                                                    );
                                            },
                                            child: Text(
                                              ('${postsList[index]['userName']}'),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                      //The text of the post
                                      Container(
                                        padding: EdgeInsets.all(
                                          5.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${postsList[index]['post']}',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //the image of the post
                                      postsList[index]['postImageFlag']
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white30,
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(40.0),
                                                  bottomLeft:
                                                      Radius.circular(40.0),
                                                  //  Radius.circular(10)
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  postsList[index]['postImage'],
                                                  height: 400.0,
                                                  width: 330.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      //the button where you can like & save & see comments
                                      K_vSpace,
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventScreen(),
            ),
          );
        },
        child: Icon(
          Icons.event,
          size: 35.0,
          color: Colors.white,
        ),
      ),
    );
  }

  void signOut() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Text(
            "Sign Out",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 21.0,
              height: 1.3,
            ),
          ),
          content: Text(
            "Confirm Sign Out",
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
                'Cancel',
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
            TextButton(
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  height: 1.3,
                ),
              ),
              onPressed: () {
                authBloc.add(SignOutButtonPressed());
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
