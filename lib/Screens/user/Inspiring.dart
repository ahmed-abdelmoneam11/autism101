import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'character_data.dart';
import 'characters_screen.dart';
import 'my_menu_items.dart';
import 'menu.dart';

class Inspiring extends StatefulWidget {
// const MyMenuItems({Key? key}) : super(key: key);

  @override
  _InspiringState createState() => _InspiringState();
}

class _InspiringState extends State<Inspiring> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
        title: Text('Inspiring People',),
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
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 200,
              maxCrossAxisExtent: 300,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20),
          padding: EdgeInsets.all(10),
          itemCount: person.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screens(todo: person[index]),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0, // soften the shadow
                      spreadRadius: 0.5, //extend the shadow
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(person[index].image),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: <Widget>[
                    Text(person[index].name,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text(person[index].date,
                        style: TextStyle(fontSize: 15, color: Colors.white))
                  ],
                ),
                padding: EdgeInsets.only(top: 155),
              ),
            );
          }),
    );
  }
}
