import 'package:autism101/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/profile_bloc.dart';
import 'package:autism101/BlocEvents/profile_bloc_events.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:like_button/like_button.dart';

class ProfileView extends StatefulWidget {
  final userDocId;
  ProfileView({this.userDocId});
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  //view another user profile not much different of user profile
  late ProfileBloc profileBloc;
  late PostsBloc postsBloc;
  String firstName = '';
  String lastName = '';
  String profilePictureUrl =
      'https://firebasestorage.googleapis.com/v0/b/autism101-4d85b.appspot.com/o/demoUserImage.jpg?alt=media&token=1bbf3bd7-017a-4299-becb-8228a29d796e';
  List postsList = [];
  List userLikes = [];
  List userFavourites = [];
  var postsCount = 0;
  var followingCount = 0;
  var followersCount = 0;
  var posts;

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(
      GetOtherUsersProfileDataEvent(
        userDocId: widget.userDocId,
      ),
    );
    postsBloc.add(
      GetOtherUsersPosts(
        userDocId: widget.userDocId,
      ),
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
          '$firstName $lastName - Profile',
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLodingState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text("   Loading...")
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is GetOtherUsersProfileDataErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is GetOtherUsersProfileDataSuccessState) {
                setState(() {
                  firstName = state.firstName;
                  lastName = state.lastName;
                  profilePictureUrl = state.profilePictureUrl;
                  postsCount = state.postsCount;
                  followingCount = state.followingCount;
                  followersCount = state.followersCount;
                });
              }
            },
          ),
          BlocListener<PostsBloc, PostsState>(
            listener: (context, state) {
              if (state is GetOtherUsersPostsSuccessState) {
                setState(() {
                  posts = state.posts;
                });
              } else if (state is GetOtherUsersPostsErrorState) {
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
          ),
        ],
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //Profile Data.
                Container(
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
                                      color: Colors.black,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Follow",
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
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        ('Posts'),
                                        style: TextStyle(
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
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        ('Followers'),
                                        style: TextStyle(
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
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        ('Following'),
                                        style: TextStyle(
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
                //Posts.
                StreamBuilder<QuerySnapshot>(
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
                      final postImageFlag = post.get('postHasImage');
                      final List postLikes = post.get('postLikes');
                      final List favourites = post.get('usersWhoFavourite');
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
                                                        postsBloc.add(
                                                          UnLikePost(
                                                            post:
                                                                postsList[index]
                                                                    ['post'],
                                                          ),
                                                        );
                                                        setState(() {
                                                          userLikes[index] =
                                                              false;
                                                        });
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
