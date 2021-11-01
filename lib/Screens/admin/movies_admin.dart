import 'package:autism101/Screens/user/Movie.dart';
import 'package:autism101/Screens/user/MovieScreen.dart';
import 'package:flutter/material.dart';

class Movie_admin extends StatefulWidget {
  @override
  _Movie_adminState createState() => _Movie_adminState();
}

class _Movie_adminState extends State<Movie_admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
            height: 900,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              image: DecorationImage(
                  image: AssetImage("assets/images/background2.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/background2.jpg'),
                            fit: BoxFit.cover,
                          )),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 90.0),
                            height: 350.0,
                            padding: EdgeInsets.all(12.0),
                            child: new ListView(
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                GestureDetector(
                                    child: Container(
                                        width: 250,
                                        // height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/movie1.jpg"),
                                              fit: BoxFit.cover),
                                        )),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Movies()),
                                      );
                                    }),
                                Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 250.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/movie2.jpg'),
                                          fit: BoxFit.cover,
                                        ))),
                                Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 250.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/movie3.jpg'),
                                          fit: BoxFit.cover,
                                        ))),
                                Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 250.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/movie4.jpg'),
                                          fit: BoxFit.cover,
                                        ))),
                                Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 250.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/movie5.jpg'),
                                          fit: BoxFit.cover,
                                        ))),
                                Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 250.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/movie6.jpg'),
                                          fit: BoxFit.cover,
                                        ))),
                                Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 250.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/movie7.jpg'),
                                          fit: BoxFit.cover,
                                        ))),
                                Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 250.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/movie8.jpg'),
                                          fit: BoxFit.cover,
                                        ))),
                              ],
                            )),
                      ]),
                      ButtonTheme(
                          minWidth: 50.0,
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {},
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              "Add Movie",
                              style: TextStyle(fontSize: 20),
                            ),
                            color: Colors.blue,
                          )),
                    ]))));
  }
}
