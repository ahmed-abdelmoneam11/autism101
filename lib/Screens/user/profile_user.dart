// ignore_for_file: must_be_immutable, deprecated_member_use
// import 'package:autism101/model/posts.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/profile_bloc.dart';
import 'package:autism101/BlocEvents/profile_bloc_events.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/Screens/user/edit_profile_screen.dart';
import 'package:autism101/Screens/user/edit_post_screen.dart';
import 'package:autism101/Constants.dart';
// import 'package:provider/provider.dart';
import 'add_posts.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late ProfileBloc profileBloc;
  late PostsBloc postsBloc;
  String firstName = '';
  String lastName = '';
  String email = '';
  String profilePictureUrl =
      'https://firebasestorage.googleapis.com/v0/b/autism101-4d85b.appspot.com/o/demoUserImage.jpg?alt=media&token=1bbf3bd7-017a-4299-becb-8228a29d796e';
  List postsList = [];
  List userLikes = [];
  List userFavourites = [];
  bool isLoading = false;
  var postsCount = 0;
  var followingCount = 0;
  var followersCount = 0;
  var posts;
  var token;

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(
      GetProfileDataEvent(),
    );
    postsBloc.add(
      GetUserPosts(),
    );
    Timer(Duration(seconds: 1), () async {
      var prefs = await SharedPreferences.getInstance();
      setState(() {
        token = prefs.getString("TOKEN");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Product> prodList =
    //     Provider.of<Products>(context, listen: true).productsList;
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '$firstName $lastName - Profile',
          style: TextStyle(
            fontFamily: "Futura",
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLodingState) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is GetProfileDataErrorState) {
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error,
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is GetProfileDataSuccessState) {
                setState(() {
                  firstName = state.firstName;
                  lastName = state.lastName;
                  email = state.email;
                  profilePictureUrl = state.profilePictureUrl;
                  postsCount = state.postsCount;
                  followingCount = state.followingCount;
                  followersCount = state.followersCount;
                  isLoading = false;
                });
              } else if (state is UpdateUserNameSuccessState ||
                  state is UpdateProfileWithEmailAndNameSuccessState ||
                  state is UpdateProfileWithEmailAndPictureSuccessState ||
                  state is UpdateUserNameAndPictureSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Profile Updated Successfully",
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
          BlocListener<PostsBloc, PostsState>(
            listener: (context, state) {
              if (state is GetUserPostsSuccessState) {
                setState(() {
                  posts = state.posts;
                });
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.lightBlue,
                        strokeWidth: 5.0,
                      )
                    //Profile Data.
                    : Container(
                        height: 200,
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
                            children: [
                              //User Picture.
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  profilePictureUrl,
                                  height: 90.0,
                                  width: 90.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              K_hSpace,
                              K_hSpace,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //User Name.
                                        Text(
                                          ('$firstName $lastName'),
                                          style: TextStyle(
                                            fontFamily: "Futura",
                                            color: Colors.black,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    K_vSpace,
                                    //Posts, Following and Followers Count.
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //Posts Count.
                                        Column(
                                          children: [
                                            Text(
                                              ('$postsCount'),
                                              style: TextStyle(
                                                  fontFamily: "Futura",
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              ('Posts'),
                                              style: TextStyle(
                                                  fontFamily: "Futura",
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        //Followers Count.
                                        Column(
                                          children: [
                                            Text(
                                              ('$followersCount'),
                                              style: TextStyle(
                                                  fontFamily: "Futura",
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              ('Followers'),
                                              style: TextStyle(
                                                  fontFamily: "Futura",
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        //Following Count.
                                        Column(
                                          children: [
                                            Text(
                                              ('$followingCount'),
                                              style: TextStyle(
                                                  fontFamily: "Futura",
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              ('Following'),
                                              style: TextStyle(
                                                  fontFamily: "Futura",
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
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
                //Edit Profile Button.
                Container(
                  height: 80.0,
                  width: 500.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadow,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            profilePictureUrl: profilePictureUrl,
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontFamily: "Futura",
                          color: Colors.blue,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                K_vSpace,
                //Posts.
                StreamBuilder<QuerySnapshot>(
                  stream: posts,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlue,
                          strokeWidth: 5.0,
                        ),
                      );
                    }
                    final postsData = snapshot.data!.docs;
                    for (var post in postsData) {
                      final postContent = post.get('post');
                      final postImageUrl = post.get('postImageUrl');
                      final postImageFlag = post.get('postHasImage');
                      final List postLikes = post.get('postLikesUID');
                      final List favourites = post.get('usersWhoFavouriteUID');
                      postImageFlag
                          ? postsList.add(
                              {
                                "post": postContent,
                                "image": postImageUrl,
                                "postImageFlag": postImageFlag,
                              },
                            )
                          : postsList.add(
                              {
                                "post": postContent,
                                "postImageFlag": postImageFlag,
                              },
                            );
                      postLikes.contains(auth.currentUser!.uid)
                          ? userLikes.add(true)
                          : userLikes.add(false);
                      favourites.contains(auth.currentUser!.uid)
                          ? userFavourites.add(true)
                          : userFavourites.add(false);
                    }
                    return snapshot.hasData
                        ? Container(
                            height: 500.0,
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  Container(
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
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Image.network(
                                                      profilePictureUrl,
                                                      height: 50.0,
                                                      width: 50.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  //the name of the user
                                                  Text(
                                                    ('    $firstName $lastName'),
                                                    style: TextStyle(
                                                      fontFamily: "Futura",
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(),
                                                  ),
                                                  //Book Mark Button.
                                                  LikeButton(
                                                    isLiked:
                                                        userFavourites[index],
                                                    onTap:
                                                        (bool isLiked) async {
                                                      if (isLiked) {
                                                        postsBloc.add(
                                                          UnFavouritePost(
                                                            post:
                                                                postsList[index]
                                                                    ['post'],
                                                          ),
                                                        );
                                                        setState(() {
                                                          userFavourites[
                                                              index] = false;
                                                        });
                                                      } else {
                                                        postsBloc.add(
                                                          FavouritePost(
                                                            post:
                                                                postsList[index]
                                                                    ['post'],
                                                          ),
                                                        );
                                                        setState(() {
                                                          userFavourites[
                                                              index] = true;
                                                        });
                                                      }
                                                      return isLiked;
                                                    },
                                                    bubblesColor: BubblesColor(
                                                      dotPrimaryColor:
                                                          Color(0xff33b5e5),
                                                      dotSecondaryColor:
                                                          Color(0xff0099cc),
                                                    ),
                                                    likeBuilder:
                                                        (bool isLiked) {
                                                      return Icon(
                                                        isLiked
                                                            ? CupertinoIcons
                                                                .bookmark_fill
                                                            : CupertinoIcons
                                                                .bookmark,
                                                        color: isLiked
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        size: 25.0,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              K_vSpace,
                                              //The text of the post
                                              Container(
                                                padding: EdgeInsets.only(
                                                  bottom: 10.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${postsList[index]['post']}',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: "Futura",
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
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                            40.0,
                                                          ),
                                                          bottomLeft:
                                                              Radius.circular(
                                                            40.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Image.network(
                                                          postsList[index]
                                                              ['image'],
                                                          height: 400.0,
                                                          width: 330.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              //the button where you can like & save & see comments
                                              K_vSpace,
                                              //Comment TextField
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  LikeButton(
                                                    isLiked: userLikes[index],
                                                    onTap:
                                                        (bool isLiked) async {
                                                      if (isLiked) {
                                                        setState(() {
                                                          userLikes[index] =
                                                              false;
                                                        });
                                                        postsBloc.add(
                                                          UnLikePost(
                                                            post:
                                                                postsList[index]
                                                                    ['post'],
                                                          ),
                                                        );
                                                      } else {
                                                        postsBloc.add(
                                                          LikePost(
                                                            post:
                                                                postsList[index]
                                                                    ['post'],
                                                          ),
                                                        );
                                                        setState(() {
                                                          userLikes[index] =
                                                              true;
                                                        });
                                                      }
                                                      return isLiked;
                                                    },
                                                  ),
                                                  //Comment.
                                                  Expanded(
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        hintText: "Comment",
                                                        prefixIcon: Icon(
                                                          Icons.comment,
                                                          color: Colors.grey,
                                                          size: 25.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  K_vSpace,
                                ],
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
