import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';

class MyNotification extends StatefulWidget {
  @override
  _MyNotificationState createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late PostsBloc postsBloc;
  List userNotifications = [];
  var notifications;

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(GetNotifications());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          } else if (state is GetNotificationsSuccessState) {
            setState(() {
              notifications = state.notifications;
            });
          } else if (state is GetNotificationsErrorState) {
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
          stream: notifications,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "No Recent Notifications",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              );
            }
            final notificationsData = snapshot.data!.docs;
            for (var notification in notificationsData) {
              final title = notification.get('notificationTitle');
              final image = notification.get('userImage');
              userNotifications.add({
                'Title': title,
                'Image': image,
              });
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading:
                      //image of the owner of the post
                      ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      userNotifications[index]['Image'],
                      height: 60.0,
                      width: 60.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Text(
                    '${userNotifications[index]['Title']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
