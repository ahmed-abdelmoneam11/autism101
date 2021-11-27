import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class PostsApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  addPost(
    String post,
    File postImage,
  ) async {
    try {
      var prefs = await SharedPreferences.getInstance();

      //Getting Current user data.
      var userEmail = auth.currentUser!.email;
      if (userEmail == null) {
        throw "User Not Found";
      }
      var queryResult = await firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
      var data = await firestore.collection('users').doc(docId).get();
      int postCount = data['postsCount'];

      //Uploading New Image.
      String fileName = Path.basename(postImage.path);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(postImage);
      await uploadTask.whenComplete(() => null).onError(
            (error, stackTrace) => throw ("Failed to upload post image"),
          );
      String uploadedImageUrl = await ref.getDownloadURL();
      prefs.setString("IMAGE", uploadedImageUrl);

      //Adding new post.
      await firestore.collection('posts').add({
        "userDocID": docId,
        "post": post,
        "postImageUrl": uploadedImageUrl,
      }).onError(
        (error, stackTrace) => throw ("Failed to add new post"),
      );

      //Updating user document.
      await firestore.collection('users').doc(docId).update({
        "postsCount": postCount + 1,
      }).onError(
        (error, stackTrace) => throw "Failed to update user data",
      );
      return {
        "code": 200,
      };
    } on Exception catch (e) {
      if (e.toString() == "Failed to add new post") {
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
      } else if (e.toString() == "Failed to update user data") {
        var prefs = await SharedPreferences.getInstance();
        var imageUrl = prefs.getString("IMAGE");
        if (imageUrl != null) {
          firebase_storage.FirebaseStorage.instance
              .refFromURL(imageUrl)
              .delete();
        }
        var queryResult = await firestore
            .collection('users')
            .where('post', isEqualTo: post)
            .limit(1)
            .get();
        var docId = queryResult.docs.first.id;
        await firestore.collection('users').doc(docId).delete();
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
}
