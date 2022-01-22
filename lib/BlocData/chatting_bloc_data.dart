import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  createChatRoom(String otherUserDocID) async {
    try {
      var firstUserQueryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var firstUserDocId = firstUserQueryResult.docs.first.id;
      var firstUserData =
          await firestore.collection('users').doc(firstUserDocId).get();
      var secondUserData =
          await firestore.collection('users').doc(otherUserDocID).get();
      var firstUserFirstName = firstUserData['firstName'];
      var firstUserLastName = firstUserData['lastName'];
      var secondUserFirstName = secondUserData['firstName'];
      var secondUserLastName = secondUserData['lastName'];

      await firestore.collection('chatRooms').add({
        "FirstUserDocID": firstUserDocId,
        "FirstUserID": firstUserData['userID'],
        "FirstUserName": "$firstUserFirstName $firstUserLastName",
        "FirstUserImage": firstUserData['ProfilePicture'],
        "SecondUserDocID": otherUserDocID,
        "SecondUserID": secondUserData['userID'],
        "SecondUserName": "$secondUserFirstName $secondUserLastName",
        "SecondUserImage": secondUserData['ProfilePicture'],
        "Users": [
          firstUserData['userID'],
          secondUserData['userID'],
        ],
        "TimeStamp": DateTime.now(),
      });
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  sendMessage(
    String otherUserDocID,
    String message,
  ) async {
    try {
      var secondUserData =
          await firestore.collection('users').doc(otherUserDocID).get();
      var chatRoomsQueryResult1 =
          await firestore.collection('chatRooms').where('Users', isEqualTo: [
        secondUserData['userID'],
        auth.currentUser!.uid,
      ]).get();
      var chatRoomsQueryResult2 =
          await firestore.collection('chatRooms').where('Users', isEqualTo: [
        auth.currentUser!.uid,
        secondUserData['userID'],
      ]).get();
      if (chatRoomsQueryResult1.docs.length != 0) {
        var chatRoomDocID = chatRoomsQueryResult1.docs.first.id;
        await firestore.collection('messages').add({
          "ChatRoomID": chatRoomDocID,
          "SenderID": auth.currentUser!.uid,
          "ReceiverID": secondUserData['userID'],
          "Message": message,
          "TimeStamp": DateTime.now(),
        });
        await firestore.collection('chatRooms').doc(chatRoomDocID).update({
          "TimeStamp": DateTime.now(),
        });
      } else if (chatRoomsQueryResult2.docs.length != 0) {
        var chatRoomDocID = chatRoomsQueryResult2.docs.first.id;
        await firestore.collection('messages').add({
          "ChatRoomID": chatRoomDocID,
          "SenderID": auth.currentUser!.uid,
          "ReceiverID": secondUserData['userID'],
          "Message": message,
          "TimeStamp": DateTime.now(),
        });
        await firestore.collection('chatRooms').doc(chatRoomDocID).update({
          "TimeStamp": DateTime.now(),
        });
      } else {
        createChatRoom(otherUserDocID);
        sendMessage(otherUserDocID, message);
      }
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  gettingChatRooms() async {
    try {
      var chatRooms = firestore
          .collection('chatRooms')
          .where('Users', arrayContains: auth.currentUser!.uid)
          .orderBy('TimeStamp', descending: true)
          .snapshots();
      return {
        "code": 200,
        "data": chatRooms,
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  gettingMessages(String otherUserDocID) async {
    try {
      var otherUserData =
          await firestore.collection('users').doc(otherUserDocID).get();

      var chatRoomsQuery1 =
          await firestore.collection('chatRooms').where('Users', isEqualTo: [
        auth.currentUser!.uid,
        otherUserData['userID'],
      ]).get();

      var chatRoomsQuery2 =
          await firestore.collection('chatRooms').where('Users', isEqualTo: [
        otherUserData['userID'],
        auth.currentUser!.uid,
      ]).get();
      if (chatRoomsQuery1.docs.length != 0) {
        var messages = firestore
            .collection('messages')
            .where('ChatRoomID', isEqualTo: chatRoomsQuery1.docs.first.id)
            .orderBy('TimeStamp', descending: true)
            .snapshots();
        return {
          "code": 200,
          "data": messages,
        };
      } else if (chatRoomsQuery2.docs.length != 0) {
        var messages = firestore
            .collection('messages')
            .where('ChatRoomID', isEqualTo: chatRoomsQuery2.docs.first.id)
            .orderBy('TimeStamp', descending: true)
            .snapshots();
        return {
          "code": 200,
          "data": messages,
        };
      } else {
        var messages = firestore.collection('messages').snapshots();
        return {
          "code": 200,
          "data": messages,
        };
      }
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }
}
