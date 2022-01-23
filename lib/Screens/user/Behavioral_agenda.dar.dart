import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/view_agenda_screen.dart';
import 'add_agenda.dart';

class MyAgendaPage extends StatefulWidget {
  @override
  State<MyAgendaPage> createState() => _MyAgendaPageState();
}

class _MyAgendaPageState extends State<MyAgendaPage> {
  late PostsBloc postsBloc;
  List agendasList = [];
  var agendas;

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(GetAgendas());
    super.initState();
  }

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
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocListener<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is PostsLodingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("  Loading...")
                  ],
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is GetAgendasSuccessState) {
            setState(() {
              agendas = state.agendas;
            });
          } else if (state is GetAgendasErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: agendas,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            final agendasData = snapshot.data!.docs;
            for (var agenda in agendasData) {
              final title = agenda.get('title');
              final content = agenda.get('content');
              final docId = agenda.id;
              agendasList.add(
                {
                  "Title": title,
                  "Content": content,
                  "DocId": docId,
                },
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.book,
                    size: 40.0,
                    color: Colors.blue,
                  ),
                  title: Text(
                    '${agendasList[index]['Title']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAgenda(
                          title: agendasList[index]['Title'],
                          content: agendasList[index]['Content'],
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    deleteAgenda(agendasList[index]['DocId']);
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => AddAgendaScreen(),
          ),
        ),
      ),
    );
  }

  deleteAgenda(String docID) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Text(
            "Delete",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 21.0,
              height: 1.3,
            ),
          ),
          content: Text(
            "Are you sure? deleting agenda will remove this agenda permanently from your agendas",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18.0,
              height: 1.3,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  height: 1.3,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  height: 1.3,
                ),
              ),
              onPressed: () {
                postsBloc.add(
                  DeleteAgenda(
                    agendaDocID: docID,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
