import 'package:autism101/Constants.dart';
import 'package:flutter/material.dart';

class School_Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: Text('Contact with school',style: TextStyle(color: Colors.black),),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(
            Icons.arrow_back,
            color: Colors.black
        )),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/school.jpeg"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MaterialButton(
                        color: Colors.blue,
                        shape: CircleBorder(),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(34),
                          child: Text(
                            'Type A',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                      MaterialButton(
                        color: Colors.redAccent,
                        shape: CircleBorder(),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(34),
                          child: Text(
                            'Type B',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: 270.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MaterialButton(
                        color: Colors.green,
                        shape: CircleBorder(),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(34),
                          child: Text(
                            'Type C',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                      MaterialButton(
                        color: Colors.deepPurple,
                        shape: CircleBorder(),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(34),
                          child: Text(
                            'Type D',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: 10.0,
                ),
              ]),
        ),
      ),
    );
  }
}
