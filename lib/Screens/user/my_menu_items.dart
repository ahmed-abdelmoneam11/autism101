import 'package:autism101/Screens/user/alarm/views/homepage.dart';
import 'package:autism101/Screens/user/event.dart';
import 'package:autism101/Screens/user/people_youMayKnow.dart';
import 'package:autism101/Screens/user/progress.dart';
import 'package:autism101/Screens/user/school_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Behavioral_agenda.dar.dart';
import 'Inspiring.dart';
import 'Movie.dart';
import 'MovieScreen.dart';

class MyMenuItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //color: Colors.black;
    return Column(
      ///Scroll Bar where user can enter Event and Favorite Lise and so on
      children: <Widget>[
        ListTile(
          title: Text('Events'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Events()),
            );
          },
          leading: const Icon(Icons.event),
        ),
        ListTile(
          title: Text('Progress'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Progress()),
            );
          },
          leading: const Icon(Icons.self_improvement),
        ),
        ListTile(
          title: Text('Favorite List '),
          onTap: () {},
          leading: const Icon(Icons.favorite_border),
        ),
        ListTile(
          title: Text('Alarm Schedule '),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          leading: const Icon(Icons.alarm),
        ),
        ListTile(
          title: Text('Movies'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Movies()),
            );
          },
          leading: const Icon(Icons.movie),
        ),
        ListTile(
          title: Text('Behavioral Agenda'),
          leading: const Icon(Icons.insert_drive_file_outlined),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAgendaPage()),
            );
          },
        ),
        ListTile(
          title: Text('People you may know'),
          leading: const Icon(Icons.people),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PeopleYouMayKnow()),
            );
          },
        ),
        ListTile(
          title: Text('Contact with School'),
          leading: const Icon(Icons.home_work_outlined),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => School_Category()),
            );
          },
        ),
        ListTile(
          title: Text('Inspiring people'),
          leading: const Icon(Icons.emoji_people_sharp),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Inspiring()),
            );
          },
        ),
        ListTile(
          title: Text('Logout'),
          leading: Transform.rotate(angle: 15.7,child: const Icon(Icons.login_rounded)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Inspiring()),
            );
          },
        ),
      ],
    );
  }
}
