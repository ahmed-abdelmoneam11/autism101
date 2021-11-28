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
      String userFirstName = data['firstName'];
      String userLastName = data['lastName'];
      String userPictureUrl = data['ProfilePicture'];

      //Uploading Post Image.
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
        "timeStamp": DateTime.now(),
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userPictureUrl": userPictureUrl,
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

  getUserPosts() async {
    try {
      //Getting Current user doc id.
      var userEmail = auth.currentUser!.email;
      if (userEmail == null) {
        throw "User Not Found";
      }
      var queryResult = await firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "User not found",
          );
      var docId = queryResult.docs.first.id;

      //Getting Current user posts.
      var posts = firestore
          .collection('posts')
          .where('userDocID', isEqualTo: docId)
          .orderBy(
            'timeStamp',
            descending: true,
          )
          .snapshots();
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

  deletePost(String post) async {
    try {
      //Find The Post to be deleted.
      var postQueryResult = await firestore
          .collection('posts')
          .where('post', isEqualTo: post)
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Post not found",
          );
      var postDocId = postQueryResult.docs.first.id;
      var postsData = await firestore.collection('posts').doc(postDocId).get();
      var postImageUrl = postsData['postImageUrl'];

      //Get User Doc ID & Posts count.
      var userDocId = postsData['userDocID'];
      var userData = await firestore.collection('users').doc(userDocId).get();
      int postsCount = userData['postsCount'];

      //Deleting Post & Image.
      await firestore.collection('posts').doc(postDocId).delete().onError(
            (error, stackTrace) => throw "Error Deleting Post",
          );
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(postImageUrl)
          .delete()
          .onError(
            (error, stackTrace) => throw "Error Deleting Post Image",
          );

      //Update posts count in user doc.
      await firestore
          .collection('users')
          .doc(userDocId)
          .update({"postsCount": postsCount - 1}).onError(
        (error, stackTrace) => throw "Error Updating Posts Count",
      );

      //Return State Code.
      return {
        "code": 200,
      };
    } on Exception catch (e) {
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  editPostContentAndImage(
    String oldPost,
    String newPost,
    File newImage,
  ) async {
    try {
      var prefs = await SharedPreferences.getInstance();

      //Find The Post to be deleted.
      var postQueryResult = await firestore
          .collection('posts')
          .where(
            'post',
            isEqualTo: oldPost,
          )
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Post not found",
          );
      var postDocId = postQueryResult.docs.first.id;
      var postsData = await firestore.collection('posts').doc(postDocId).get();
      var postImageUrl = postsData['postImageUrl'];

      //Deleting old post image.
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(postImageUrl)
          .delete()
          .onError(
            (error, stackTrace) => throw "Error Deleting Post Image",
          );

      //Uploading new post image.
      String fileName = Path.basename(newImage.path);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(newImage);
      await uploadTask.whenComplete(() => null).onError(
            (error, stackTrace) => throw "Failed to upload post image",
          );
      String uploadedImageUrl = await ref.getDownloadURL();
      prefs.setString("IMAGE", uploadedImageUrl);

      //Updating post doc.
      await firestore.collection('posts').doc(postDocId).update({
        "post": newPost,
        "postImageUrl": uploadedImageUrl,
      }).onError(
        (error, stackTrace) => throw "Can't Update Post",
      );

      //Return State Code.
      return {
        "code": 200,
      };
    } on Exception catch (e) {
      if (e.toString() == "Can't Update Post") {
        var prefs = await SharedPreferences.getInstance();
        var imageUrl = prefs.getString("IMAGE");
        if (imageUrl != null) {
          firebase_storage.FirebaseStorage.instance
              .refFromURL(imageUrl)
              .delete();
        }
      }
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  editPostContent(
    String oldPost,
    String newPost,
  ) async {
    try {
      //Find The Post to be deleted.
      var postQueryResult = await firestore
          .collection('posts')
          .where(
            'post',
            isEqualTo: oldPost,
          )
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Post not found",
          );
      var postDocId = postQueryResult.docs.first.id;

      //Updating post doc.
      await firestore.collection('posts').doc(postDocId).update({
        "post": newPost,
      }).onError(
        (error, stackTrace) => throw "Can't Update Post",
      );

      //Return State Code.
      return {
        "code": 200,
      };
    } on Exception catch (e) {
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  editPostImage(
    String oldPost,
    File newImage,
  ) async {
    try {
      var prefs = await SharedPreferences.getInstance();

      //Find The Post to be deleted.
      var postQueryResult = await firestore
          .collection('posts')
          .where(
            'post',
            isEqualTo: oldPost,
          )
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Post not found",
          );
      var postDocId = postQueryResult.docs.first.id;
      var postsData = await firestore.collection('posts').doc(postDocId).get();
      var postImageUrl = postsData['postImageUrl'];

      //Deleting old post image.
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(postImageUrl)
          .delete()
          .onError(
            (error, stackTrace) => throw "Error Deleting Post Image",
          );

      //Uploading new post image.
      String fileName = Path.basename(newImage.path);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(newImage);
      await uploadTask.whenComplete(() => null).onError(
            (error, stackTrace) => throw "Failed to upload post image",
          );
      String uploadedImageUrl = await ref.getDownloadURL();
      prefs.setString("IMAGE", uploadedImageUrl);

      //Updating post doc.
      await firestore.collection('posts').doc(postDocId).update({
        "postImageUrl": uploadedImageUrl,
      }).onError(
        (error, stackTrace) => throw "Can't Update Post",
      );

      //Return State Code.
      return {
        "code": 200,
      };
    } on Exception catch (e) {
      if (e.toString() == "Can't Update Post") {
        var prefs = await SharedPreferences.getInstance();
        var imageUrl = prefs.getString("IMAGE");
        if (imageUrl != null) {
          firebase_storage.FirebaseStorage.instance
              .refFromURL(imageUrl)
              .delete();
        }
      }
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }
}
