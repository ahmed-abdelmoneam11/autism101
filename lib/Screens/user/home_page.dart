import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/view_profile.dart';
import 'package:autism101/Screens/user/add_posts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

double? deviceHeight;
double? deviceWidth;

class _HomePageState extends State<HomePage> {
  late PostsBloc postsBloc;
  //her where the posts of the people you follow will be in
  List imageList = [
    'assets/images/s1.png',
    'assets/images/s2.png',
    'assets/images/s3.png',
  ];
  List postsList = [];
  var posts;

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(
      GetTimeLinePosts(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduct(),
            ),
          );
        },
        child: Icon(
          CupertinoIcons.pencil_outline,
          color: Colors.white,
        ),
      ),
      body: BlocListener<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is GetTimeLinePostsSuccessState) {
            setState(() {
              posts = state.posts;
            });
          } else if (state is GetTimeLinePostsErrorState) {
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Most Important Topics',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                K_vSpace,
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    aspectRatio: 5.0,
                    height: 200,
                    initialPage: 0,
                  ),
                  items: imageList.map((imageUrl) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/SchoolAccount');
                      },
                      child: Container(
                        width: double.infinity,
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                K_vSpace,
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                K_vSpace,
                SizedBox(
                  height: 150.0,
                  width: 400,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2, // soften the shadow
                                    spreadRadius: 0.1, //extend the shadow
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/s2.png',
                                    ),
                                    fit: BoxFit.cover)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0.1, 0.9])),
                              child: Column(
                                children: <Widget>[
                                  Expanded(child: Container()),
                                  Text('Medical',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        //Use of SizedBox
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2, // soften the shadow
                                    spreadRadius: 0.1, //extend the shadow
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/s2.png',
                                    ),
                                    fit: BoxFit.cover)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0.1, 0.9])),
                              child: Column(
                                children: <Widget>[
                                  Expanded(child: Container()),
                                  Text('Educational',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        //Use of SizedBox
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2, // soften the shadow
                                    spreadRadius: 0.1, //extend the shadow
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/s2.png',
                                    ),
                                    fit: BoxFit.cover)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0.1, 0.9])),
                              child: Column(
                                children: <Widget>[
                                  Expanded(child: Container()),
                                  Text('Behavioural',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                K_vSpace,
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
                      final userFirstName = post.get('userFirstName');
                      final userLastName = post.get('userLastName');
                      final userPictureUrl = post.get('userPictureUrl');
                      final userDocId = post.get('userDocID');
                      postsList.add(
                        {
                          "post": postContent,
                          "postImage": postImageUrl,
                          "userName": '$userFirstName $userLastName',
                          "userPicture": userPictureUrl,
                          "userDocId": userDocId,
                        },
                      );
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
                                    width: 350,
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
                                                      postsList[index]
                                                          ['userPicture'],
                                                      height: 50.0,
                                                      width: 50.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  //the name of the user
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProfileView(
                                                            userDocId: postsList[
                                                                    index]
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
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(),
                                                  ),
                                                  //Like Button.
                                                  LikeButton(
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
                                                  )
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
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white30,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(40.0),
                                                    //  Radius.circular(10)
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      postsList[index]
                                                          ['postImage'],
                                                      height: 400.0,
                                                      width: 330.0,
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              //the button where you can like & save & see comments
                                              K_vSpace,
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    LikeButton(),
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
                                                  ]),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
