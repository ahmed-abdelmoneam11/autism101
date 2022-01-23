import 'package:flutter/material.dart';
import 'package:autism101/Screens/categories/Behavioural/behavioural1.dart';
import 'package:autism101/Screens/categories/Behavioural/behavioural2.dart';
import 'package:autism101/Screens/categories/Behavioural/behavioural3.dart';
import 'package:autism101/Screens/categories/Behavioural/behavioural4.dart';
import 'package:autism101/Constants.dart';

class BehaviouralMainScreen extends StatelessWidget {
  final List topics = [
    "How to Help an Autistic Child Build Artistic Skills",
    "The Importance of Social Skills Therapy for Autism",
    "What Is Applied Behavioral Analysis (ABA) Therapy for Autism?",
    "Why Your Child With Autism Echoes, Words and Sounds",
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
          "Behavioural",
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
              if (topics[index] ==
                  "How to Help an Autistic Child Build Artistic Skills") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Behavioural(),
                  ),
                );
              } else if (topics[index] ==
                  "The Importance of Social Skills Therapy for Autism") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Behavioural2(),
                  ),
                );
              } else if (topics[index] ==
                  "What Is Applied Behavioral Analysis (ABA) Therapy for Autism?") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Behavioural3(),
                  ),
                );
              } else if (topics[index] ==
                  "Why Your Child With Autism Echoes, Words and Sounds") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Behavioural4(),
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
