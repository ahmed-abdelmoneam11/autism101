import 'package:autism101/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'Behavioral_agenda.dar.dart';

class AddAgenda extends StatefulWidget {
  ///her is the dart code where take the data from agenda module and put it in agenda screen

  @override
  _AddAgendaState createState() => _AddAgendaState();
}

class _AddAgendaState extends State<AddAgenda> {
  var titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF8F9FF),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          CupertinoIcons.checkmark_alt,
          color: Colors.white,
          size: 30.0,
        ),
        onPressed: () {},
      ),
      appBar: AppBar(
          shape: appBarShape,
          backgroundColor: Colors.white,
          title: Text(
            'Add Agenda',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => MyAgendaPage())),
          )),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              maxLines: 10,
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                hintText: "Type here...",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.transparent,
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.transparent,
                )),
              ),
              controller: titleController,
            ),
          ],
        ),
      ),
    );
  }
}
