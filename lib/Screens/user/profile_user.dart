// ignore_for_file: must_be_immutable, deprecated_member_use
// import 'package:autism101/model/posts.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:autism101/Screens/user/home_screen.dart';
// import 'package:provider/provider.dart';
import 'add_posts.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        backgroundColor: Colors.lightBlue,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.lightBlue,
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
                        Text("  Loading...")
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is GetProfileDataErrorState) {
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
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 70.0,
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  )),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    //profile image
                    CircleAvatar(
                        radius: (52),
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            profilePictureUrl,
                            fit: BoxFit.fitWidth,
                            height: 100.0,
                            width: 100.0,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    //user name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          firstName,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          lastName,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    //user email
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black12,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //number of posts & followers & following
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 22.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '$postsCount',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Posts",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '$followersCount',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '$followingCount',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Following",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //add post and edit profile bottom
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          //Add Post Button.
                          ButtonTheme(
                              minWidth: 20.0,
                              height: 10.0,
                              child: RaisedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => AddProduct())),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                child: Text(
                                  "Add Post",
                                  style: TextStyle(fontSize: 20),
                                ),
                                color: Colors.blue,
                              )),
                          //Edit Profile Button.
                          ButtonTheme(
                              minWidth: 20.0,
                              height: 10.0,
                              child: RaisedButton(
                                onPressed: () {
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
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                child: Text(
                                  "Edit Profile",
                                  style: TextStyle(fontSize: 20),
                                ),
                                color: Colors.blue,
                              )),
                        ]),
                    //posts
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
                          postLikes.contains(token)
                              ? userLikes.add(true)
                              : userLikes.add(false);
                          favourites.contains(token)
                              ? userFavourites.add(true)
                              : userFavourites.add(false);
                        }
                        return snapshot.hasData
                            ? Container(
                                height: 450.0,
                                width: double.infinity,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: postsCount,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      Container(
                                        width: 400.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(40.0),
                                            bottomLeft: Radius.circular(40.0),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                //image of the user
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Image.network(
                                                      profilePictureUrl,
                                                      height: 50.0,
                                                      width: 50.0,
                                                      fit: BoxFit.cover,
                                                    )),
                                                //name of the user
                                                TextButton(
                                                  onPressed: null,
                                                  child: Text(
                                                    ('$firstName $lastName'),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                                //edit button
                                                ButtonTheme(
                                                  minWidth: 20.0,
                                                  height: 10.0,
                                                  child: RaisedButton(
                                                      color: Colors
                                                          .lightBlueAccent,
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    EditPost(
                                                              post: postsList[
                                                                      index]
                                                                  ['post'],
                                                              postImageUrl:
                                                                  postsList[
                                                                          index]
                                                                      ['image'],
                                                              imageFlag: postsList[
                                                                      index][
                                                                  'postImageFlag'],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      shape:
                                                          new RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(30.0),
                                                      ),
                                                      child: new SizedBox(
                                                        height: 18.0,
                                                        width: 18.0,
                                                        child: new IconButton(
                                                          color: Colors.blue,
                                                          padding:
                                                              new EdgeInsets
                                                                  .all(0.0),
                                                          icon: new Icon(
                                                            Icons.edit,
                                                            size: 18.0,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditPost(
                                                                  post: postsList[
                                                                          index]
                                                                      ['post'],
                                                                  postImageUrl:
                                                                      postsList[
                                                                              index]
                                                                          [
                                                                          'image'],
                                                                  imageFlag: postsList[
                                                                          index]
                                                                      [
                                                                      'postImageFlag'],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )
                                                      //  color: Colors.blue,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            //caption of the post
                                            ClipRRect(
                                              //  borderRadius: BorderRadius.circular(50),
                                              child: Card(
                                                color: Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                elevation: 3,
                                                child: Text(
                                                  postsList[index]['post'],
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            //image of the post
                                            postsList[index]['postImageFlag']
                                                ? ClipRRect(
                                                    child: Image.network(
                                                      postsList[index]['image'],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Container(),
                                            //like & save & show comment button
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                //Like Button.
                                                LikeButton(
                                                  isLiked: userLikes[index],
                                                  onTap: (bool isLiked) async {
                                                    if (isLiked) {
                                                      postsBloc.add(
                                                        UnLikePost(
                                                          post: postsList[index]
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
                                                          post: postsList[index]
                                                              ['post'],
                                                        ),
                                                      );
                                                      setState(() {
                                                        userLikes[index] = true;
                                                      });
                                                    }
                                                    return isLiked;
                                                  },
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.comment,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                                //Save Button.
                                                LikeButton(
                                                  isLiked:
                                                      userFavourites[index],
                                                  onTap: (bool isLiked) async {
                                                    if (isLiked) {
                                                      postsBloc.add(
                                                        UnFavouritePost(
                                                          post: postsList[index]
                                                              ['post'],
                                                        ),
                                                      );
                                                      setState(() {
                                                        userFavourites[index] =
                                                            false;
                                                      });
                                                    } else {
                                                      postsBloc.add(
                                                        FavouritePost(
                                                          post: postsList[index]
                                                              ['post'],
                                                        ),
                                                      );
                                                      setState(() {
                                                        userFavourites[index] =
                                                            true;
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
                                                  likeBuilder: (bool isLiked) {
                                                    return Icon(
                                                      isLiked
                                                          ? CupertinoIcons
                                                              .bookmark_fill
                                                          : CupertinoIcons
                                                              .bookmark,
                                                      color: isLiked
                                                          ? Color(0xffFFC900)
                                                          : Colors.black,
                                                      size: 25.0,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            //write comment field
                                            SizedBox(
                                              width: 300,
                                              height: 30,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    labelText: 'Comment',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    )),
                                              ),
                                            ),
                                            //space
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
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
          ],
        ),
      ),
    );
  }
}
