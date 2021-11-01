import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/add_posts.dart';
import 'package:autism101/model/posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange,
          canvasColor: Color.fromRGBO(255, 238, 219, 1)),
      debugShowCheckedModeBanner: false,
      home: SchoolProfile(),
    );
  }
}

class SchoolProfile extends StatelessWidget {
  ///profile page

  @override
  Widget build(BuildContext context) {
    List<Product> prodList =
        Provider.of<Products>(context, listen: true).productsList;

    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: Text('Autism school - Profile',style: TextStyle(color: Colors.black),),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(
            Icons.arrow_back,
            color: Colors.black
        )),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              K_vSpace,
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/school1.png',
                            height: 90.0,
                            width: 90.0,
                            fit: BoxFit.cover,
                          )),
                      K_hSpace,
                      K_hSpace,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ('Autism school'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            K_vSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Posts
                                Column(
                                  children: [
                                    Text(
                                      ('18'),
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
                                //Followers
                                Column(
                                  children: [
                                    Text(
                                      ('0'),
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
                                //Following
                                Column(
                                  children: [
                                    Text(
                                      ('18'),
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
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Edit profile',
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Add event',
                          ))

                    ],
                  ),
                ),
              ),
              K_vSpace,
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          ///the inf of the owner of the post
                          Row(
                            children: <Widget>[
                              ///image of the owner of the post//////////////////////
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    'assets/images/school1.png',
                                    height: 50.0,
                                    width: 50.0,
                                    fit: BoxFit.cover,
                                  )),
                              ///the name of the user //////////////////
                              TextButton(
                                //    onPressed: (null),
                                onPressed: () {

                                },
                                child: Text(
                                  ('Autism school'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Expanded(child: Container()),

                            ],
                          ),
                          K_vSpace,

                          ///the image of the post
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0),
                                  //  Radius.circular(10)
                                )),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/school1.png',
                                  height: 400.0,
                                  width: 330.0,
                                  fit: BoxFit.cover,
                                )),
                          ),

                          ///the button where you can like & save & see comments

                          K_vSpace,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[

                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
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
              K_vSpace,
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          ///the inf of the owner of the post
                          Row(
                            children: <Widget>[
                              ///image of the owner of the post//////////////////////
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    'assets/images/school1.png',
                                    height: 50.0,
                                    width: 50.0,
                                    fit: BoxFit.cover,
                                  )),

                              ///the name of the user //////////////////
                              TextButton(
                                //    onPressed: (null),
                                onPressed: () {

                                },
                                child: Text(
                                  ('Autism school'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Expanded(child: Container()),

                            ],
                          ),
                          K_vSpace,

                          ///the image of the post
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0),
                                  //  Radius.circular(10)
                                )),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/school1.png',
                                  height: 400.0,
                                  width: 330.0,
                                  fit: BoxFit.cover,
                                )),
                          ),

                          ///the button where you can like & save & see comments

                          K_vSpace,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                //icon heart
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
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
            ],
          ),
        ),
      ),
    );
  }
}
