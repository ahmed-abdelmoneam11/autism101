// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/view_profile.dart';
import 'package:autism101/Screens/user/profile_user.dart';

class PostDetails extends StatefulWidget {
  final String post;
  final String postImage;
  final String userName;
  final String userPicture;
  final String userDocId;
  final String userID;
  final bool postImageFlag;
  final List postLikes;
  final List postFavorites;
  final List postComments;
  PostDetails({
    required this.post,
    required this.postImage,
    required this.userName,
    required this.userPicture,
    required this.userDocId,
    required this.userID,
    required this.postImageFlag,
    required this.postLikes,
    required this.postFavorites,
    required this.postComments,
  });
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _commentController = TextEditingController();
  late PostsBloc postsBloc;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
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
          "Post Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
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
                            widget.userPicture,
                            height: 50.0,
                            width: 50.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                        //the name of the user
                        TextButton(
                          onPressed: () {
                            widget.userID == auth.currentUser!.uid
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyHomePage(),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileView(
                                        userDocId: widget.userDocId,
                                      ),
                                    ),
                                  );
                          },
                          child: Text(
                            '${widget.userName}',
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
                          isLiked: widget.postFavorites
                              .contains(auth.currentUser!.uid),
                          onTap: (bool isLiked) async {
                            if (isLiked) {
                              postsBloc.add(
                                UnFavouritePost(
                                  post: widget.post,
                                ),
                              );
                              setState(() {
                                widget.postFavorites
                                    .remove(auth.currentUser!.uid);
                              });
                            } else {
                              postsBloc.add(
                                FavouritePost(
                                  post: widget.post,
                                ),
                              );
                              setState(() {
                                widget.postFavorites.add(auth.currentUser!.uid);
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
                              color: isLiked ? Colors.blue : Colors.grey,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.post}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //the image of the post
                    widget.postImageFlag
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
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.postImage,
                                height: 400.0,
                                width: 330.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(),
                    //the button where you can like & save & see comments
                    K_vSpace,
                    //Like Button & Comment Field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        LikeButton(
                          isLiked:
                              widget.postLikes.contains(auth.currentUser!.uid),
                          onTap: (bool isLiked) async {
                            if (isLiked) {
                              postsBloc.add(
                                UnLikePost(
                                  post: widget.post,
                                ),
                              );
                              setState(() {
                                widget.postLikes.remove(auth.currentUser!.uid);
                              });
                            } else {
                              postsBloc.add(
                                LikePost(
                                  post: widget.post,
                                ),
                              );
                              setState(() {
                                widget.postLikes.add(auth.currentUser!.uid);
                              });
                            }
                            return isLiked;
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _commentController,
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
                                onPressed: () {
                                  if (_commentController.text.isEmpty) {
                                    Toast.show(
                                      "Write a comment.",
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                    );
                                  } else {
                                    postsBloc.add(
                                      AddComment(
                                        post: widget.post,
                                        comment: _commentController.text,
                                      ),
                                    );
                                    _commentController.clear();
                                  }
                                },
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

                    widget.postComments.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.all(3.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.postComments.length,
                              itemBuilder: (context, index) => ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    widget.postComments[index]['userImage'],
                                    height: 45.0,
                                    width: 45.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                title: Text(
                                  '${widget.postComments[index]['userName']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(
                                  '${widget.postComments[index]['comment']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
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
