import 'package:autism101/model/posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_posts.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange,
          canvasColor: Color.fromRGBO(255, 238, 219, 1)),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  ///profile page

  @override
  Widget build(BuildContext context) {
    List<Product> prodList =
        Provider.of<Products>(context, listen: true).productsList;

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 100.0,
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
                  ///profile image
                  CircleAvatar(
                      radius: (52),
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/images/ibrahim.png",
                          fit: BoxFit.fitWidth,
                          height: 100.0,
                          width: 100.0,
                        ),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),

                  ///user name
                  Text(
                    "Ibrahim Shawki ",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    ),
                  ),

                  ///user email
                  Text(
                    "IbrahimShawki@gmail.com ",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black12,
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),

                  ///number of posts & followers & following
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
                                  "5200",
                                  style: TextStyle(
                                    fontSize: 15.0,
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
                                    fontSize: 15.0,
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
                                  "28.5K",
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
                                  "1300",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Follow",
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

                  ///add post and edit profile bottom
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ButtonTheme(
                            minWidth: 20.0,
                            height: 10.0,
                            child: RaisedButton(
                              onPressed: () => Navigator.pushReplacement(
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
                        ButtonTheme(
                            minWidth: 20.0,
                            height: 10.0,
                            child: RaisedButton(
                              onPressed: () {},
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

                  ///posts
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0),
                          //  Radius.circular(10)
                        )),
                    child: prodList.isEmpty

                        ///if there is no post will show that
                        ? Center(
                            child: Text('Get Start your first post.',
                                style: TextStyle(fontSize: 22)))

                        ///the post
                        : Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              children: prodList

                                  ///map in the list of the post
                                  .map((item) => Column(children: <Widget>[
                                        Container(
                                          width: 350,
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0),
                                                //  Radius.circular(10)
                                              )),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  ///image of the user
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Image.asset(
                                                        'assets/images/ibrahim.png',
                                                        height: 50.0,
                                                        width: 50.0,
                                                        fit: BoxFit.cover,
                                                      )),

                                                  ///name of the user
                                                  TextButton(
                                                    onPressed: null,
                                                    child: Text(
                                                      ('Ibrahim Shawki'),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),

                                                  ///edit button
                                                  ButtonTheme(
                                                      minWidth: 20.0,
                                                      height: 10.0,
                                                      child: RaisedButton(
                                                          color: Colors
                                                              .lightBlueAccent,
                                                          onPressed: () {},
                                                          shape:
                                                              new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    30.0),
                                                          ),
                                                          child: new SizedBox(
                                                              height: 18.0,
                                                              width: 18.0,
                                                              child:
                                                                  new IconButton(
                                                                color:
                                                                    Colors.blue,
                                                                padding:
                                                                    new EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                icon: new Icon(
                                                                  Icons.edit,
                                                                  size: 18.0,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                onPressed: null,
                                                              ))
                                                          //  color: Colors.blue,
                                                          )),
                                                ],
                                              ),

                                              ///caption of the post
                                              ClipRRect(
                                                //  borderRadius: BorderRadius.circular(50),
                                                child: Card(
                                                  color: Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  elevation: 3,
                                                  child: Text(
                                                    item.title,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                              ),

                                              ///image of the post
                                              ClipRRect(
                                                child: Image.file(item.image!,
                                                    fit: BoxFit.cover),
                                              ),

                                              ///like & save & show comment button
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.comment,
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.label_important,
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ]),

                                              ///write comment field
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
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      )),
                                                ),
                                              ),

                                              ///space
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50.0,
                                        ),
                                      ]))
                                  .toList(),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
