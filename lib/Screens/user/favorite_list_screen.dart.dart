import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/post_details_screen.dart';
import 'package:autism101/Screens/user/view_profile.dart';
import 'package:autism101/Screens/user/profile_user.dart';

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late PostsBloc postsBloc;
  List postsList = [];
  List userLikes = [];
  List userFavourites = [];
  bool isLoading = false;
  var posts;

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(
      GetFavouritePosts(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Favorite List",
          style: TextStyle(
            fontFamily: "Futura",
            color: Colors.black,
            fontSize: 25.0,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is GetFavouritePostsSuccessState) {
            setState(() {
              posts = state.posts;
            });
          } else if (state is GetFavouritePostsErrorState) {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: StreamBuilder<QuerySnapshot>(
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
                final userFirstName = post.get('userFirstName');
                final userLastName = post.get('userLastName');
                final userPictureUrl = post.get('userPictureUrl');
                final userDocId = post.get('userDocID');
                final userID = post.get('userID');
                final postImageFlag = post.get('postHasImage');
                final List postLikes = post.get('postLikes');
                final List favourites = post.get('usersWhoFavourite');
                final List comments = post.get('comments');
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
                          "postLikes": postLikes,
                          "postFavorites": favourites,
                          "postComments": comments,
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
                          "postLikes": postLikes,
                          "postFavorites": favourites,
                          "postComments": comments,
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
                  ? ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) => Column(
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
                                          postsList[index]['userPicture'],
                                          height: 50.0,
                                          width: 50.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      //the name of the user
                                      TextButton(
                                        onPressed: () {
                                          posts[index]['userID'] ==
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
                                                      userDocId: posts[index]
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
                                      //Book Mark Button.
                                      LikeButton(
                                        isLiked: userFavourites[index],
                                        onTap: (bool isLiked) async {
                                          if (isLiked) {
                                            postsBloc.add(
                                              UnFavouritePost(
                                                post: postsList[index]['post'],
                                              ),
                                            );
                                            setState(() {
                                              userFavourites[index] = false;
                                            });
                                          } else {
                                            postsBloc.add(
                                              FavouritePost(
                                                post: postsList[index]['post'],
                                              ),
                                            );
                                            setState(() {
                                              userFavourites[index] = true;
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
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostDetails(
                                            post: postsList[index]['post'],
                                            postImage: postsList[index]
                                                ['postImage'],
                                            postImageFlag: postsList[index]
                                                ['postImageFlag'],
                                            userName: postsList[index]
                                                ['userName'],
                                            userDocId: postsList[index]
                                                ['userDocId'],
                                            userID: postsList[index]['userID'],
                                            userPicture: postsList[index]
                                                ['userPicture'],
                                            postLikes: postsList[index]
                                                ['postLikes'],
                                            postComments: postsList[index]
                                                ['postComments'],
                                            postFavorites: postsList[index]
                                                ['postFavorites'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
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
                                  ),
                                  //the image of the post
                                  postsList[index]['postImageFlag']
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
                                                postsList[index]['postImage'],
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
                                                post: postsList[index]['post'],
                                              ),
                                            );
                                            setState(() {
                                              userLikes[index] = false;
                                            });
                                          } else {
                                            postsBloc.add(
                                              LikePost(
                                                post: postsList[index]['post'],
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
                      ),
                    )
                  : Center(
                      child: Text("No Posts"),
                    );
            }),
      ),
    );
  }
}
