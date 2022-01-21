import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/chatting_bloc.dart';
import 'package:autism101/BlocEvents/chatting_bloc_events.dart';
import 'package:autism101/BlocStates/chatting_bloc_state.dart';
import 'package:autism101/Screens/user/chat_screen.dart';

class ChatRooms extends StatefulWidget {
  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late ChatBloc chatBloc;
  var chatRooms;
  List rooms = [];

  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(GetChatRooms());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is GettingChatRoomsSuccessState) {
            setState(() {
              chatRooms = state.chatRooms;
            });
          } else if (state is GettingChatRoomsErrorState) {
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
          stream: chatRooms,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "No Recent Chats",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              );
            }
            final chatRoomsData = snapshot.data!.docs;
            for (var room in chatRoomsData) {
              final firstUserDocID = room.get('FirstUserDocID');
              final firstUserID = room.get('FirstUserID');
              final firstUserName = room.get('FirstUserName');
              final firstUserImage = room.get('FirstUserImage');
              final secondUserDocID = room.get('SecondUserDocID');
              final secondUserID = room.get('SecondUserID');
              final secondUserName = room.get('SecondUserName');
              final secondUserImage = room.get('SecondUserImage');
              final List users = room.get('Users');
              users.indexOf(auth.currentUser!.uid) == 0
                  ? rooms.add({
                      'UserDocID': secondUserDocID,
                      'UserID': secondUserID,
                      'UserName': secondUserName,
                      'UserImage': secondUserImage,
                    })
                  : rooms.add({
                      'UserDocID': firstUserDocID,
                      'UserID': firstUserID,
                      'UserName': firstUserName,
                      'UserImage': firstUserImage,
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
                      rooms[index]['UserImage'],
                      height: 60.0,
                      width: 60.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Text(
                    '${rooms[index]['UserName']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          userName: rooms[index]['UserName'],
                          userImage: rooms[index]['UserImage'],
                          userDocId: rooms[index]['UserDocID'],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
