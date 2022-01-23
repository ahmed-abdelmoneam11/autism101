import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class EventsApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  addEvent(
    String name,
    String facebookLink,
    String bio,
    File image,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      //Uploading movie Image.
      String fileName = Path.basename(image.path);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(image);
      await uploadTask.whenComplete(() => null).onError(
            (error, stackTrace) => throw ("Failed to upload image"),
          );
      String uploadedImageUrl = await ref.getDownloadURL();
      prefs.setString("IMAGE", uploadedImageUrl);

      //Adding new post.
      await firestore.collection('events').add({
        "Name": name,
        "Bio": bio,
        "Facebook Link": facebookLink,
        "ImageUrl": uploadedImageUrl,
        "joinedUsers": [],
        "InterestedUsers": [],
      }).onError(
        (error, stackTrace) => throw ("Failed to add new event"),
      );
      return {
        "code": 200,
      };
    } on Exception catch (e) {
      if (e.toString() == "Failed to add new event") {
        var prefs = await SharedPreferences.getInstance();
        var imageUrl = prefs.getString("IMAGE");
        if (imageUrl != null) {
          firebase_storage.FirebaseStorage.instance
              .refFromURL(imageUrl)
              .delete();
        }
        return {
          "code": 400,
          "message": e.toString(),
        };
      } else {
        return {
          "code": 400,
          "message": e.toString(),
        };
      }
    }
  }

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
      joins.add(auth.currentUser!.uid);
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
      joins.remove(auth.currentUser!.uid);
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
      interests.add(auth.currentUser!.uid);
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
      interests.remove(auth.currentUser!.uid);
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
