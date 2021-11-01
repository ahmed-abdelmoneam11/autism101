import 'package:autism101/model/characters.dart';
import 'package:flutter/material.dart';

class Screens extends StatelessWidget {
  final Character todo;

  Screens({Key? key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerScrimColor: Colors.white.withOpacity(0.4),
        appBar: AppBar(
          title: Text(todo.name,),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(200),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(todo.image), fit: BoxFit.cover),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(todo.name,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold)),
                  Text(todo.date,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold))
                ],
              ),
              padding: EdgeInsets.only(top: 15),
            ),
          ],
        ));
  }
}
