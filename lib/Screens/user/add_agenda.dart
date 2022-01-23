// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/Constants.dart';

class AddAgendaScreen extends StatefulWidget {
  @override
  _AddAgendaScreenState createState() => _AddAgendaScreenState();
}

class _AddAgendaScreenState extends State<AddAgendaScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  late PostsBloc postsBloc;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    super.initState();
  }

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
        onPressed: addAgenda,
      ),
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: Text(
          'Add Agenda',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is PostsLodingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: <Widget>[
                    CircularProgressIndicator(
                      color: Colors.lightBlue,
                    ),
                    Text("  Loading...")
                  ],
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is AddAgendaErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is AddAgendaSuccessState) {
            Navigator.pop(context);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  hintText: "Enter Title...",
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
              SizedBox(
                height: 20.0,
              ),
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
                controller: contentController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  addAgenda() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Toast.show("No internet connection !", context,
          duration: Toast.LENGTH_LONG);
    } else if (titleController.text.isEmpty) {
      Toast.show("Enter Title", context, duration: Toast.LENGTH_LONG);
    } else if (contentController.text.isEmpty) {
      Toast.show("Enter Content", context, duration: Toast.LENGTH_LONG);
    } else {
      postsBloc.add(AddAgenda(
        title: titleController.text,
        content: contentController.text,
      ));
    }
  }
}
