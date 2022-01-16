import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/view_profile.dart';
import 'package:autism101/Screens/user/profile_user.dart';

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  late PostsBloc postsBloc;
  List posts = [];
  List likes = [];
  List favourites = [];
  List userLikes = [];
  List userFavorites = [];
  bool isLoading = false;
  var token;

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(
      GetFavouritePosts(),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Favorite List",
          style: TextStyle(
            fontFamily: "Futura",
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is PostsLodingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is GetFavouritePostsSuccessState) {
            setState(() {
              posts = state.posts;
              likes = state.likes;
              favourites = state.favourites;
              isLoading = false;
            });
            gettingUserLikes();
            gettingUserFavorites();
          } else if (state is GetFavouritePostsErrorState) {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlue,
                  strokeWidth: 5.0,
                ),
              )
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) => posts.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 15.0,
                          ),
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
                                children: [
                                  //the inf of the owner of the post
                                  Row(
                                    children: <Widget>[
                                      //image of the owner of the post
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          posts[index]['userPicture'],
                                          height: 50.0,
                                          width: 50.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      //the name of the user
                                      TextButton(
                                        onPressed: () {
                                          // posts[index]['userID'] == token
                                          //     ? Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               MyHomePage(),
                                          //         ),
                                          //       )
                                          //     : Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               ProfileView(
                                          //             userDocId: posts[index]
                                          //                 ['userDocId'],
                                          //           ),
                                          //         ),
                                          //       );
                                        },
                                        child: Text(
                                          ('${posts[index]['userName']}'),
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
                                      //Book Mark Button.
                                      LikeButton(
                                        isLiked: userFavorites[index],
                                        onTap: (bool isLiked) async {
                                          if (isLiked) {
                                            postsBloc.add(
                                              UnFavouritePost(
                                                post: posts[index]['post'],
                                              ),
                                            );
                                            setState(() {
                                              userFavorites[index] = false;
                                            });
                                          } else {
                                            postsBloc.add(
                                              FavouritePost(
                                                post: posts[index]['post'],
                                              ),
                                            );
                                            setState(() {
                                              userFavorites[index] = true;
                                            });
                                          }
                                          return isLiked;
                                        },
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor: Color(0xff33b5e5),
                                          dotSecondaryColor: Color(0xff0099cc),
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          return Icon(
                                            isLiked
                                                ? CupertinoIcons.bookmark_fill
                                                : CupertinoIcons.bookmark,
                                            color: isLiked
                                                ? Colors.blue
                                                : Colors.grey,
                                            size: 25.0,
                                          );
                                        },
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
                                          '${posts[index]['post']}',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //the image of the post
                                  posts[index]['postImageFlag']
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white30,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomLeft: Radius.circular(40.0),
                                              //  Radius.circular(10)
                                            ),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                posts[index]['postImage'],
                                                height: 400.0,
                                                width: 330.0,
                                                fit: BoxFit.cover,
                                              )),
                                        )
                                      : Container(),
                                  //the button where you can like & save & see comments
                                  K_vSpace,
                                  //Like Button & Comment Field
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      LikeButton(
                                        isLiked: userLikes[index],
                                        onTap: (bool isLiked) async {
                                          if (isLiked) {
                                            postsBloc.add(
                                              UnLikePost(
                                                post: posts[index]['post'],
                                              ),
                                            );
                                            setState(() {
                                              userLikes[index] = false;
                                            });
                                          } else {
                                            postsBloc.add(
                                              LikePost(
                                                post: posts[index]['post'],
                                              ),
                                            );
                                            setState(() {
                                              userLikes[index] = true;
                                            });
                                          }
                                          return isLiked;
                                        },
                                      ),
                                      Expanded(
                                        child: TextField(
                                          // controller:
                                          //     _commentController,
                                          decoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            hintText: "Comment",
                                            prefixIcon: Icon(
                                              Icons.comment,
                                              color: Colors.grey,
                                              size: 25.0,
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.send,
                                                color: Colors.blue,
                                                size: 25.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          "No Posts Available !",
                          style: TextStyle(
                            fontFamily: "Futura",
                            fontSize: 25.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
              ),
      ),
    );
  }

  void gettingUserLikes() {
    Future.delayed(
      Duration(seconds: 2),
    );
    if (posts.isNotEmpty) {
      for (var i = 0; i < posts.length; i++) {
        if (userLikes.length < posts.length) {
          setState(() {
            userLikes.add(false);
          });
        }
        if (likes.isNotEmpty) {
          for (var j = 0; j < likes.length; j++) {
            if (token == likes[j]) {
              setState(() {
                userLikes[i] = true;
              });
            }
          }
        }
      }
    }
  }

  void gettingUserFavorites() {
    Future.delayed(
      Duration(seconds: 2),
    );
    if (posts.isNotEmpty) {
      for (var i = 0; i < posts.length; i++) {
        if (userFavorites.length < posts.length) {
          setState(() {
            userFavorites.add(false);
          });
        }
        if (favourites.isNotEmpty) {
          for (var j = 0; j < favourites.length; j++) {
            if (token == favourites[j]) {
              setState(() {
                userFavorites[i] = true;
              });
            }
          }
        }
      }
    }
  }
}
