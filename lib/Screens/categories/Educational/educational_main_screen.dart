import 'package:flutter/material.dart';
import 'package:autism101/Screens/categories/Educational/educational1.dart';
import 'package:autism101/Screens/categories/Educational/educational2.dart';
import 'package:autism101/Screens/categories/Educational/educational3.dart';
import 'package:autism101/Constants.dart';

class EducationalMainScreen extends StatelessWidget {
  final List topics = [
    "How to Homeschool Your Autistic Child",
    "Private Schools for Children with Autism",
    "Sending an Autistic Child to Public School",
  ];
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
          "Educational",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(
              '${topics[index]}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              if (topics[index] == "How to Homeschool Your Autistic Child") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Educational1(),
                  ),
                );
              } else if (topics[index] ==
                  "Private Schools for Children with Autism") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Educational2(),
                  ),
                );
              } else if (topics[index] ==
                  "Sending an Autistic Child to Public School") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Educational3(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
