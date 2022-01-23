import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/home_screen.dart';
import 'package:autism101/model/agendas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_agenda.dart';

class MyAgendaPage extends StatelessWidget {
  ///where the user will create new agenda and see the old one

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: K_backColor,
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: Text(
          'Behavioural Agenda',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[]),
              Container(
                width: 350,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Column(
                        children: <Widget>[
                          //Container of agenda
                          Dismissible(
                            background: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                  K_hSpace
                                ],
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            key: UniqueKey(),
                            child: Container(
                              width: double.infinity,
                              child: Card(
                                color: Colors.white,
                                elevation: 1.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "(item.title)",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.add),
        onPressed: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => AddAgenda())),
      ),
    );
  }
}
