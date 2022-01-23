import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/view_profile.dart';
import 'package:autism101/Screens/user/profile_user.dart';
import 'package:autism101/Screens/user/add_posts.dart';
import 'package:autism101/Screens/user/post_details_screen.dart';
import 'package:autism101/Screens/most_Important_topics/areas_affected_screen.dart';
import 'package:autism101/Screens/most_Important_topics/chalenges_screen.dart';
import 'package:autism101/Screens/most_Important_topics/causes_screen.dart';
import 'package:autism101/Screens/most_Important_topics/what_autism_screen.dart';
import 'package:autism101/Screens/most_Important_topics/types_screen.dart';
import 'package:autism101/Screens/most_Important_topics/frequently_asked_questions.dart';
import 'package:autism101/Screens/most_Important_topics/how_autism_is_treated.dart';
import 'package:autism101/Screens/most_Important_topics/the_common_misconceptions_of_autism.dart';
import 'package:autism101/Screens/categories/Medical/medical_main_screen.dart';
import 'package:autism101/Screens/categories/Educational/educational_main_screen.dart';
import 'package:autism101/Screens/categories/Behavioural/main_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

double? deviceHeight;
double? deviceWidth;
FirebaseAuth auth = FirebaseAuth.instance;

class _HomePageState extends State<HomePage> {
  TextEditingController _commentController = TextEditingController();
  late PostsBloc postsBloc;
  //her where the posts of the people you follow will be in
  List imageList = [
    'assets/images/whatisautism.jpg',
    'assets/images/typesofautism.jpg',
    'assets/images/Areasarethatmaybeaffectedbyautism2.jpg',
    'assets/images/AutismChalengesandstrengths.jpg',
    'assets/images/causes.jpg',
    'assets/images/FREQUENTLYASKEDQUESTIONS.jpg',
    'assets/images/HowAutismIsTreated.jpg',
    'assets/images/TheCommonMisconceptionsOfAutism.jpg',
  ];
  List postsList = [];
  List userLikes = [];
  List userFavourites = [];
  var posts;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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
              children: [
                //Most Important Topics.
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
                        if (imageUrl ==
                            'assets/images/Areasarethatmaybeaffectedbyautism2.jpg') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Areas(),
                            ),
                          );
                        } else if (imageUrl ==
                            'assets/images/AutismChalengesandstrengths.jpg') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Chalenges(),
                            ),
                          );
                        } else if (imageUrl == 'assets/images/causes.jpg') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Causes(),
                            ),
                          );
                        } else if (imageUrl ==
                            'assets/images/whatisautism.jpg') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WhatIsAutism(),
                            ),
                          );
                        } else if (imageUrl ==
                            'assets/images/typesofautism.jpg') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Types(),
                            ),
                          );
                        } else if (imageUrl ==
                            'assets/images/FREQUENTLYASKEDQUESTIONS.jpg') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FrequentlyAskedQuestions(),
                            ),
                          );
                        } else if (imageUrl ==
                            'assets/images/HowAutismIsTreated.jpg') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HowAutismIsTreated(),
                            ),
                          );
                        } else if (imageUrl ==
                            'assets/images/TheCommonMisconceptionsOfAutism.jpg') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TheCommonMisconceptionsOfAutism(),
                            ),
                          );
                        }
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
                //Categories.
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
                      //Medical.
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicalMainScreen(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2, // soften the shadow
                                  spreadRadius: 0.1, //extend the shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/medical.jfif',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [0.1, 0.9],
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Text(
                                    'Medical',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //Educational.
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EducationalMainScreen(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2, // soften the shadow
                                  spreadRadius: 0.1, //extend the shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/educational.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [0.1, 0.9],
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Text(
                                    'Educational',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //Behavioural.
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BehaviouralMainScreen(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2, // soften the shadow
                                  spreadRadius: 0.1, //extend the shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/behavioural.jfif',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [0.1, 0.9],
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Text(
                                    'Behavioural',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
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
                      final userID = post.get('userID');
                      final postImageFlag = post.get('postHasImage');
                      final List postLikes = post.get('postLikes');
                      final List favourites = post.get('usersWhoFavourite');
                      final postDocID = post.id;
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
                                "postDocID": postDocID,
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
                                "postDocID": postDocID,
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
                                                      postsList[index]
                                                                  ['userID'] ==
                                                              auth.currentUser!
                                                                  .uid
                                                          ? Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MyHomePage(),
                                                              ),
                                                            )
                                                          : Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ProfileView(
                                                                  userDocId: postsList[
                                                                          index]
                                                                      [
                                                                      'userDocId'],
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
                                                            FontWeight.w400,
                                                      ),
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
                                              //The text of the post
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PostDetails(
                                                        post: postsList[index]
                                                            ['post'],
                                                        postImage:
                                                            postsList[index]
                                                                ['postImage'],
                                                        postImageFlag: postsList[
                                                                index]
                                                            ['postImageFlag'],
                                                        userName:
                                                            postsList[index]
                                                                ['userName'],
                                                        userDocId:
                                                            postsList[index]
                                                                ['userDocId'],
                                                        userID: postsList[index]
                                                            ['userID'],
                                                        userPicture:
                                                            postsList[index]
                                                                ['userPicture'],
                                                        postLikes:
                                                            postsList[index]
                                                                ['postLikes'],
                                                        postFavorites: postsList[
                                                                index]
                                                            ['postFavorites'],
                                                        postDocID:
                                                            postsList[index]
                                                                ['postDocID'],
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
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  40.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  40.0),
                                                          //  Radius.circular(10)
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Image.network(
                                                          postsList[index]
                                                              ['postImage'],
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
                                                  SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Icon(
                                                    Icons.comment,
                                                    color: Colors.grey,
                                                    size: 25.0,
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PostDetails(
                                                            post:
                                                                postsList[index]
                                                                    ['post'],
                                                            postImage: postsList[
                                                                    index]
                                                                ['postImage'],
                                                            postImageFlag:
                                                                postsList[index]
                                                                    [
                                                                    'postImageFlag'],
                                                            userName: postsList[
                                                                    index]
                                                                ['userName'],
                                                            userDocId: postsList[
                                                                    index]
                                                                ['userDocId'],
                                                            userID:
                                                                postsList[index]
                                                                    ['userID'],
                                                            userPicture: postsList[
                                                                    index]
                                                                ['userPicture'],
                                                            postLikes: postsList[
                                                                    index]
                                                                ['postLikes'],
                                                            postFavorites:
                                                                postsList[index]
                                                                    [
                                                                    'postFavorites'],
                                                            postDocID: postsList[
                                                                    index]
                                                                ['postDocID'],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Add Comment",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 18.0,
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
