import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/events_bloc.dart';
import 'package:autism101/BlocEvents/events_bloc_events.dart';
import 'package:autism101/BlocStates/events_bloc_state.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/event_details_screen.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  FirebaseAuth auth = FirebaseAuth.instance;
  List eventsList = [];
  List joins = [];
  List interests = [];
  late EventsBloc eventsBloc;
  var events;
  var token;

  @override
  void initState() {
    eventsBloc = BlocProvider.of<EventsBloc>(context);
    eventsBloc.add(GetEvents());
    Timer(Duration(seconds: 1), () async {
      var prefs = await SharedPreferences.getInstance();
      setState(() {
        token = prefs.getString("TOKEN");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        title: Text(
          'Available Events',
          style: TextStyle(
            fontFamily: "Futura",
            color: Colors.black,
            fontSize: 20.0,
          ),
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
      backgroundColor: Colors.white,
      body: BlocListener<EventsBloc, EventsState>(
        listener: (context, state) {
          if (state is GetEventsSuccessState) {
            setState(() {
              events = state.events;
            });
          } else if (state is GetEventsErrorState) {
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
          stream: events,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlue,
                  strokeWidth: 5.0,
                ),
              );
            }
            final eventsData = snapshot.data!.docs;
            for (var event in eventsData) {
              final eventName = event.get('Name');
              final eventImageUrl = event.get('ImageUrl');
              final eventLink = event.get('Facebook Link');
              final eventBio = event.get('Bio');
              final List joinsList = event.get('joinedUsers');
              final List interestsList = event.get('InterestedUsers');
              eventsList.add(
                {
                  "Event Name": eventName,
                  "Event Image": eventImageUrl,
                  "Event Link": eventLink,
                  "Event Bio": eventBio,
                },
              );
              joinsList.contains(auth.currentUser!.uid)
                  ? joins.add(true)
                  : joins.add(false);
              interestsList.contains(auth.currentUser!.uid)
                  ? interests.add(true)
                  : interests.add(false);
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              //Event Name.
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //Event Name.
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EventDetails(
                                            eventName: eventsList[index]
                                                ['Event Name'],
                                            eventImage: eventsList[index]
                                                ['Event Image'],
                                            eventLink: eventsList[index]
                                                ['Event Link'],
                                            eventBio: eventsList[index]
                                                ['Event Bio'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      ('${eventsList[index]['Event Name']}'),
                                      style: TextStyle(
                                        fontFamily: "Futura",
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              K_vSpace,
                              //Event Image.
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40.0),
                                    bottomLeft: Radius.circular(40.0),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    '${eventsList[index]['Event Image']}',
                                    height: 400.0,
                                    width: 330.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              K_vSpace,
                              //Interested & Join Buttons.
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  //Interested Button.
                                  TextButton(
                                    onPressed: () {
                                      if (interests[index]) {
                                        eventsBloc.add(
                                          UnInterestEvent(
                                            eventName: eventsList[index]
                                                ['Event Name'],
                                          ),
                                        );
                                        setState(() {
                                          interests[index] = false;
                                        });
                                      } else {
                                        eventsBloc.add(
                                          InterestEvent(
                                            eventName: eventsList[index]
                                                ['Event Name'],
                                          ),
                                        );
                                        setState(() {
                                          interests[index] = true;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Interested',
                                      style: interests[index]
                                          ? TextStyle(
                                              fontFamily: "Futura",
                                              color: Colors.black,
                                              fontSize: 16.0,
                                            )
                                          : TextStyle(
                                              fontFamily: "Futura",
                                              fontSize: 16.0,
                                            ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    width: 0.5,
                                    height: 50,
                                  ),
                                  //Join Button.
                                  TextButton(
                                    onPressed: () {
                                      if (joins[index]) {
                                        eventsBloc.add(
                                          UnJoinEvent(
                                            eventName: eventsList[index]
                                                ['Event Name'],
                                          ),
                                        );
                                        setState(() {
                                          joins[index] = false;
                                        });
                                      } else {
                                        eventsBloc.add(
                                          JoinEvent(
                                            eventName: eventsList[index]
                                                ['Event Name'],
                                          ),
                                        );
                                        setState(() {
                                          joins[index] = true;
                                        });
                                      }
                                    },
                                    child: Text(
                                      joins[index] ? 'Joined' : 'Join',
                                      style: joins[index]
                                          ? TextStyle(
                                              fontFamily: "Futura",
                                              color: Colors.black,
                                              fontSize: 16.0,
                                            )
                                          : TextStyle(
                                              fontFamily: "Futura",
                                              fontSize: 16.0,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container();
          },
        ),
      ),
    );
  }

  void initializeJoinsAndInterests(int eventsLength) {
    for (var i = 0; i < eventsLength; i++) {
      if (joins.length < eventsLength) {
        joins.add(false);
      }
      if (interests.length < eventsLength) {
        interests.add(false);
      }
    }
  }

  void gettingUserJoins(List userJoins) {
    for (int i = 0; i < joins.length; i++) {
      for (var j = 0; j < userJoins.length; j++) {
        if (token == userJoins[j]) {
          joins[i] = true;
        }
      }
    }
  }

  void gettingUserInterests(List userInterests) {
    for (int i = 0; i < interests.length; i++) {
      for (var j = 0; j < userInterests.length; j++) {
        if (token == userInterests[j]) {
          interests[i] = true;
        }
      }
    }
  }
}
