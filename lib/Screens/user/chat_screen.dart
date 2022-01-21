// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/chatting_bloc.dart';
import 'package:autism101/BlocEvents/chatting_bloc_events.dart';
import 'package:autism101/BlocStates/chatting_bloc_state.dart';
import 'package:autism101/Screens/user/view_profile.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userImage;
  final userDocId;
  ChatScreen({
    required this.userName,
    required this.userImage,
    required this.userDocId,
  });
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _message = TextEditingController();
  late ChatBloc chatBloc;
  List messagesData = [];
  var messages;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(GetMessages(otherUserDocID: widget.userDocId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileView(
                  userDocId: widget.userDocId,
                ),
              ),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.userImage),
                radius: 20.0,
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                widget.userName,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is GettingMessagesSuccessState) {
            setState(() {
              messages = state.messages;
            });
          } else if (state is GettingMessagesErrorState) {
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
          stream: messages,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            final messagesStream = snapshot.data!.docs;
            List<MessageBubble> messageBubbles = [];
            for (var msg in messagesStream) {
              final sender = msg.get('SenderID');
              // final receiver = msg.get('ReceiverID');
              final message = msg.get('Message');
              final messageDocID = msg.id;
              if (auth.currentUser!.uid == sender) {
                final messageBubble = MessageBubble(
                  messageText: message,
                  isMe: true,
                  messageDocID: messageDocID,
                );
                messageBubbles.add(messageBubble);
              } else {
                final messageBubble = MessageBubble(
                  messageText: message,
                  isMe: false,
                  messageDocID: messageDocID,
                );
                messageBubbles.add(messageBubble);
              }
            }
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 60),
              reverse: true,
              children: messageBubbles.isNotEmpty
                  ? messageBubbles
                  : [
                      Container(),
                    ],
            );
          },
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
          left: 15.0,
        ),
        child: Row(
          children: [
            Container(
              width: 330.0,
              height: 60.0,
              child: TextField(
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
                controller: _message,
                decoration: InputDecoration(
                  fillColor: Colors.blue,
                  hintText: "Start a message",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.0,
                    height: 1.0,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                cursorColor: Colors.blue,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send),
                    color: Colors.blue,
                    iconSize: 30.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Toast.show("No internet connection !", context,
          duration: Toast.LENGTH_LONG);
    } else if (_message.text.isEmpty) {
      Toast.show(
        "Write a message.",
        context,
        duration: Toast.LENGTH_LONG,
      );
    } else {
      chatBloc.add(
        SendMessage(
          otherUserDocID: widget.userDocId,
          message: _message.text,
        ),
      );
      _message.clear();
      setState(() {});
    }
  }
}

class MessageBubble extends StatelessWidget {
  final String messageText;
  final String messageDocID;
  final bool isMe;
  MessageBubble({
    required this.messageText,
    required this.isMe,
    required this.messageDocID,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12),
                ),
              ],
              color: isMe ? Colors.greenAccent.shade100 : Colors.white,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(10.0),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(5.0),
                    ),
            ),
            child: Text(
              messageText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19.0,
                // fontFamily: KPrimaryFontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
