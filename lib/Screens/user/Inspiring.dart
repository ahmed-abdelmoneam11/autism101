import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/admin_bloc.dart';
import 'package:autism101/BlocEvents/admin_bloc_events.dart';
import 'package:autism101/BlocStates/admin_bloc_state.dart';
import 'package:autism101/Screens/user/characters_screen.dart';

class Inspiring extends StatefulWidget {
  final bool isAdmin;
  Inspiring({required this.isAdmin});
  @override
  _InspiringState createState() => _InspiringState();
}

class _InspiringState extends State<Inspiring> {
  late AdminBloc adminBloc;
  var inspiring;
  List inspiringsList = [];

  @override
  void initState() {
    adminBloc = BlocProvider.of<AdminBloc>(context);
    adminBloc.add(GetInspiringEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        title: Text(
          'Inspiring People',
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
      body: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminLodingState) {
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
          } else if (state is GetInspiringSuccessState) {
            setState(() {
              inspiring = state.inspiring;
            });
          } else if (state is GetInspiringErrorState) {
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
          stream: inspiring,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "No Movies Yet",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              );
            }
            final inspiringsData = snapshot.data!.docs;
            for (var inspirings in inspiringsData) {
              final name = inspirings.get('name');
              final brief = inspirings.get('brief');
              final date = inspirings.get('date');
              final autismCase = inspirings.get('autismCase');
              final imageUrl = inspirings.get('imageUrl');
              inspiringsList.add(
                {
                  'Name': name,
                  'Brief': brief,
                  'Date': date,
                  'AutismCase': autismCase,
                  'ImageUrl': imageUrl,
                },
              );
            }
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 200,
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20),
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data!.size,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Screens(
                          autismCase: inspiringsList[index]['AutismCase'],
                          brief: inspiringsList[index]['Brief'],
                          date: inspiringsList[index]['Date'],
                          imageUrl: inspiringsList[index]['ImageUrl'],
                          isAdmin: widget.isAdmin,
                          name: inspiringsList[index]['Name'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 0.5, //extend the shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(inspiringsList[index]['ImageUrl']),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          inspiringsList[index]['Name'],
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          inspiringsList[index]['Date'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    padding: EdgeInsets.only(top: 155),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton.extended(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AddMovieScreen(),
                //   ),
                // );
              },
              label: Row(
                children: [
                  Text(
                    "Add People",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Icon(
                    Icons.add,
                    size: 30.0,
                  ),
                ],
              ),
              backgroundColor: Colors.deepPurpleAccent,
              isExtended: true,
            )
          : null,
    );
  }
}
