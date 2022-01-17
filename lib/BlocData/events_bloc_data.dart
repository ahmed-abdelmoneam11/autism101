import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  getEvents() async {
    try {
      //Getting Events.
      var posts = firestore.collection('events').snapshots();
      return {
        "code": 200,
        "data": posts,
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  joinEvent(String name) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      var eventQueryResult = await firestore
          .collection('events')
          .where('Name', isEqualTo: name)
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Event not found",
          );
      var eventDocId = eventQueryResult.docs.first.id;
      var eventsData =
          await firestore.collection('events').doc(eventDocId).get();
      List joins = eventsData['joinedUsers'];
      var token = prefs.getString("TOKEN");
      joins.add(token);
      await firestore
          .collection('events')
          .doc(eventDocId)
          .update({"joinedUsers": joins}).onError(
        (error, stackTrace) => throw "Failed to join event",
      );
    } on Exception catch (e) {
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  unJoinEvent(String name) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      var eventQueryResult = await firestore
          .collection('events')
          .where('Name', isEqualTo: name)
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Event not found",
          );
      var eventDocId = eventQueryResult.docs.first.id;
      var eventsData =
          await firestore.collection('events').doc(eventDocId).get();
      List joins = eventsData['joinedUsers'];
      var token = prefs.getString("TOKEN");
      joins.remove(token);
      await firestore
          .collection('events')
          .doc(eventDocId)
          .update({"joinedUsers": joins}).onError(
        (error, stackTrace) => throw "Failed to join event",
      );
    } on Exception catch (e) {
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  interestEvent(String name) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      var eventQueryResult = await firestore
          .collection('events')
          .where('Name', isEqualTo: name)
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Event not found",
          );
      var eventDocId = eventQueryResult.docs.first.id;
      var eventsData =
          await firestore.collection('events').doc(eventDocId).get();
      List interests = eventsData['InterestedUsers'];
      var token = prefs.getString("TOKEN");
      interests.add(token);
      await firestore
          .collection('events')
          .doc(eventDocId)
          .update({"InterestedUsers": interests}).onError(
        (error, stackTrace) => throw "Failed to join event",
      );
    } on Exception catch (e) {
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  unInterestEvent(String name) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      var eventQueryResult = await firestore
          .collection('events')
          .where('Name', isEqualTo: name)
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Event not found",
          );
      var eventDocId = eventQueryResult.docs.first.id;
      var eventsData =
          await firestore.collection('events').doc(eventDocId).get();
      List interests = eventsData['InterestedUsers'];
      var token = prefs.getString("TOKEN");
      interests.remove(token);
      await firestore
          .collection('events')
          .doc(eventDocId)
          .update({"InterestedUsers": interests}).onError(
        (error, stackTrace) => throw "Failed to join event",
      );
    } on Exception catch (e) {
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }
}
