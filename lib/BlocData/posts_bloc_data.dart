import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class PostsApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  addPost(String post) async {
    try {
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
      var data = await firestore.collection('users').doc(docId).get();
      int postCount = data['postsCount'];
      String userFirstName = data['firstName'];
      String userLastName = data['lastName'];
      String userPictureUrl = data['ProfilePicture'];

      //Adding new post.
      await firestore.collection('posts').add({
        "userDocID": docId,
        "userID": auth.currentUser!.uid,
        "post": post,
        "postImageUrl": "",
        "timeStamp": DateTime.now(),
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userPictureUrl": userPictureUrl,
        "postHasImage": false,
        "usersWhoFavourite": [],
        "postLikes": [],
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
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  addPostWithImage(
    String post,
    File postImage,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
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
        "userID": auth.currentUser!.uid,
        "post": post,
        "postImageUrl": uploadedImageUrl,
        "timeStamp": DateTime.now(),
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userPictureUrl": userPictureUrl,
        "postHasImage": true,
        "usersWhoFavourite": [],
        "postLikes": [],
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
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
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

  getOtherUsersPosts(String userDocId) async {
    try {
      //Getting Current user posts.
      var posts = firestore
          .collection('posts')
          .where('userDocID', isEqualTo: userDocId)
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

  getTimeLinePosts() async {
    try {
      //Getting Posts.
      var posts = firestore
          .collection('posts')
          .orderBy(
            'timeStamp',
            descending: true,
          )
          .snapshots();
      if (await posts.isEmpty) {
        throw "No Posts Available";
      }
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

  getFavouritePosts() async {
    try {
      //Getting Posts.
      var posts = firestore
          .collection('favoritePosts')
          .where('usersWhoFavourite', arrayContains: auth.currentUser!.uid)
          .orderBy(
            'timeStamp',
            descending: true,
          )
          .snapshots();
      if (await posts.isEmpty) {
        throw "No Posts Available";
      }
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

  getNotfications() async {
    try {
      //Getting Notifications.
      var notifications = firestore
          .collection('notifications')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .orderBy(
            'timeStamp',
            descending: true,
          )
          .snapshots();
      if (await notifications.isEmpty) {
        throw "No Notifications Available";
      }
      return {
        "code": 200,
        "data": notifications,
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  likePost(String post) async {
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
      List likes = postsData['postLikes'];
      likes.add(auth.currentUser!.uid);
      await firestore.collection('posts').doc(postDocId).update({
        "postLikes": likes,
      }).onError(
        (error, stackTrace) => throw "Failed to like post",
      );
      var favoritePostQueryResult = await firestore
          .collection('favoritePosts')
          .where('post', isEqualTo: post)
          .limit(1)
          .get();
      var favoritePostDocId = favoritePostQueryResult.docs.first.id;
      await firestore
          .collection('favoritePosts')
          .doc(favoritePostDocId)
          .update({
        "postLikes": likes,
      });
      var userQueryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var userDocId = userQueryResult.docs.first.id;
      var userData = await firestore.collection('users').doc(userDocId).get();
      await firestore.collection('notifications').add({
        "userID": postsData['userID'],
        "notificationTitle":
            '${userData['firstName']} ${userData['lastName']} Liked Your Post',
        "userImage": userData['ProfilePicture'],
        "timeStamp": DateTime.now(),
      });
    } on Exception catch (e) {
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  unLikePost(String post) async {
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
      List likes = postsData['postLikes'];
      likes.remove(auth.currentUser!.uid);
      await firestore.collection('posts').doc(postDocId).update({
        "postLikes": likes,
      }).onError(
        (error, stackTrace) => throw "Failed to unlike post",
      );
      var favoritePostQueryResult = await firestore
          .collection('favoritePosts')
          .where('post', isEqualTo: post)
          .limit(1)
          .get();
      var favoritePostDocId = favoritePostQueryResult.docs.first.id;
      await firestore
          .collection('favoritePosts')
          .doc(favoritePostDocId)
          .update({
        "postLikes": likes,
      });
    } on Exception catch (e) {
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  favouritePost(String post) async {
    try {
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
      List usersWhoFavourite = postsData['usersWhoFavourite'];
      usersWhoFavourite.add(auth.currentUser!.uid);
      await firestore.collection('posts').doc(postDocId).update({
        "usersWhoFavourite": usersWhoFavourite,
      }).onError(
        (error, stackTrace) => throw "Failed to favourite post",
      );
      await firestore.collection('favoritePosts').add({
        "userDocID": postsData['userDocID'],
        "userID": postsData['userID'],
        "post": postsData['post'],
        "postImageUrl": postsData['postImageUrl'],
        "timeStamp": postsData['timeStamp'],
        "userFirstName": postsData['userFirstName'],
        "userLastName": postsData['userLastName'],
        "userPictureUrl": postsData['userPictureUrl'],
        "postHasImage": postsData['postHasImage'],
        "usersWhoFavourite": usersWhoFavourite,
        "postLikes": postsData['postLikes'],
      }).onError(
        (error, stackTrace) => throw "Failed to favourite post",
      );
    } on Exception catch (e) {
      //Return State Code & Error Message.
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  unFavouritePost(String post) async {
    try {
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
      List usersWhoFavourite = postsData['usersWhoFavourite'];
      usersWhoFavourite.remove(auth.currentUser!.uid);
      await firestore.collection('posts').doc(postDocId).update({
        "usersWhoFavourite": usersWhoFavourite,
      }).onError(
        (error, stackTrace) => throw "Failed to favourite post",
      );
      var favoritePostQueryResult = await firestore
          .collection('favoritePosts')
          .where('post', isEqualTo: post)
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Post not found",
          );
      var favoritePostDocId = favoritePostQueryResult.docs.first.id;
      await firestore
          .collection('favoritePosts')
          .doc(favoritePostDocId)
          .delete();
    } on Exception catch (e) {
      //Return State Code & Error Message.
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

      //Get User Doc ID & Posts count.
      var userDocId = postsData['userDocID'];
      var userData = await firestore.collection('users').doc(userDocId).get();
      int postsCount = userData['postsCount'];

      if (postsData['postHasImage']) {
        await firebase_storage.FirebaseStorage.instance
            .refFromURL(postsData['postImageUrl'])
            .delete()
            .onError(
              (error, stackTrace) => throw "Error Deleting Post Image",
            );
      }

      //Deleting Post & Image.
      await firestore.collection('posts').doc(postDocId).delete().onError(
            (error, stackTrace) => throw "Error Deleting Post",
          );

      //Update posts count in user doc.
      await firestore
          .collection('users')
          .doc(userDocId)
          .update({"postsCount": postsCount - 1}).onError(
        (error, stackTrace) => throw "Error Updating Posts Count",
      );
      var favoritePostQueryResult = await firestore
          .collection('favoritePosts')
          .where('post', isEqualTo: post)
          .limit(1)
          .get();
      var favoritePostDocId = favoritePostQueryResult.docs.first.id;
      await firestore
          .collection('favoritePosts')
          .doc(favoritePostDocId)
          .delete();
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
      var favoritePostQueryResult = await firestore
          .collection('favoritePosts')
          .where('post', isEqualTo: oldPost)
          .limit(1)
          .get();
      var favoritePostDocId = favoritePostQueryResult.docs.first.id;
      await firestore
          .collection('favoritePosts')
          .doc(favoritePostDocId)
          .update({
        "post": newPost,
        "postImageUrl": uploadedImageUrl,
      });
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
      var favoritePostQueryResult = await firestore
          .collection('favoritePosts')
          .where('post', isEqualTo: oldPost)
          .limit(1)
          .get();
      var favoritePostDocId = favoritePostQueryResult.docs.first.id;
      await firestore
          .collection('favoritePosts')
          .doc(favoritePostDocId)
          .update({
        "post": newPost,
      });
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
      var favoritePostQueryResult = await firestore
          .collection('favoritePosts')
          .where('post', isEqualTo: oldPost)
          .limit(1)
          .get();
      var favoritePostDocId = favoritePostQueryResult.docs.first.id;
      await firestore
          .collection('favoritePosts')
          .doc(favoritePostDocId)
          .update({
        "postImageUrl": uploadedImageUrl,
      });
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

  editPostAddImage(
    String post,
    File postImage,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      var queryResult = await firestore
          .collection('posts')
          .where('post', isEqualTo: post)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
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
      await firestore.collection('posts').doc(docId).update({
        "postImageUrl": uploadedImageUrl,
        "postHasImage": true,
      }).onError(
        (error, stackTrace) => throw ("Failed to add new post"),
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
      } else {
        return {
          "code": 400,
          "message": e.toString(),
        };
      }
    }
  }
}
