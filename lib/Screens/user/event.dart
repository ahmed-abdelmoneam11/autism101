import 'package:autism101/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  ///event Screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: Text('Available Events',style: TextStyle(color: Colors.black),),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(
            Icons.arrow_back,
            color: Colors.black
        )),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
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
                                  'assets/images/ibrahim.png',
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
                                ('Ibrahim Shawki'),
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
                                'assets/images/ibrahim.png',
                                height: 400.0,
                                width: 330.0,
                                fit: BoxFit.cover,
                              )),
                        ),

                        ///the button where you can like & save & see comments

                        K_vSpace,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              TextButton(
                                  onPressed: (){

                              },
                                  child: Text('Interested',style: TextStyle(fontSize: 16.0),)
                              ),
                              Container(
                                color: Colors.grey,
                                width: 0.5,
                                height: 50,
                              ),
                              TextButton(
                                  onPressed: (){

                                  },
                                  child: Text('Join',style: TextStyle(fontSize: 16.0),)
                              ),
                        ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
