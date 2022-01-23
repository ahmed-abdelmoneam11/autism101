import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autism101/Constants.dart';

class ViewAgenda extends StatefulWidget {
  final String title;
  final String content;
  ViewAgenda({
    required this.title,
    required this.content,
  });
  @override
  State<ViewAgenda> createState() => _ViewAgendaState();
}

class _ViewAgendaState extends State<ViewAgenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: K_backColor,
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: Text(
          '${widget.title}',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.title}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '${widget.content}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
