import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class ProfileApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  getProfileData() async {
    try {
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
      var data = await firestore.collection('users').doc(docId).get();

      return {
        "code": 200,
        "firstName": data['firstName'],
        "lastName": data['lastName'],
        "email": data['email'],
        "ProfilePicture": data['ProfilePicture'],
        "postsCount": data['postsCount'],
        "followingCount": data['followingCount'],
        "followersCount": data['followersCount'],
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  getOtherUsersProfileData(String userDocId) async {
    try {
      var data =
          await firestore.collection('users').doc(userDocId).get().onError(
                (error, stackTrace) => throw "User Not Found",
              );
      return {
        "code": 200,
        "firstName": data['firstName'],
        "lastName": data['lastName'],
        "ProfilePicture": data['ProfilePicture'],
        "followers": data['followers'],
        "postsCount": data['postsCount'],
        "followingCount": data['followingCount'],
        "followersCount": data['followersCount'],
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  getPeopleYouMayKnow() async {
    try {
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
      var userData = await firestore.collection('users').doc(docId).get();
      List following = userData['following'];
      if (following.isNotEmpty) {
        var users = firestore
            .collection('users')
            .where('userID', whereNotIn: following)
            .snapshots();
        return {
          "code": 200,
          "data": users,
        };
      } else {
        var users = firestore
            .collection('users')
            .where('userID', isNotEqualTo: auth.currentUser!.uid)
            .snapshots();
        return {
          "code": 200,
          "data": users,
        };
      }
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  getSchools() async {
    try {
      var schools = firestore
          .collection('schools')
          .where('isVerified', isEqualTo: true)
          .snapshots();
      if (await schools.isEmpty) {
        throw "No Schools Available";
      }
      return {
        "code": 200,
        "data": schools,
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  getSchoolData() async {
    try {
      var schoolQuery = await firestore
          .collection('schools')
          .where('schoolID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var schoolDocID = schoolQuery.docs.first.id;
      var schoolData =
          await firestore.collection('schools').doc(schoolDocID).get().onError(
                (error, stackTrace) => throw ("Failed To Get School Data"),
              );
      return {
        "code": 200,
        "WebSite": schoolData['website'],
        "Image": schoolData['imageUrl'],
        "DocID": schoolDocID,
        "FollowersCount": schoolData['followersCount'],
        "EventsCount": schoolData['eventsCount'],
        "Phone": schoolData['phone'],
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  searchUser(String query) async {
    try {
      if (query.contains('@')) {
        var queryResult = firestore
            .collection('users')
            .where('email', isEqualTo: query)
            .snapshots();
        return {
          "code": 200,
          "data": queryResult,
        };
      } else {
        var queryResult = firestore
            .collection('users')
            .where('firstName', isEqualTo: query)
            .snapshots();
        return {
          "code": 200,
          "data": queryResult,
        };
      }
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  updateProfileName(
    String firstName,
    String lastName,
  ) async {
    try {
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
      await firestore.collection('users').doc(docId).update({
        "firstName": firstName,
        "lastName": lastName,
      });
      return {
        "code": 200,
        "message": "Profile Updated Successfully",
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  updateProfileNameAndEmail(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
      var data = await firestore.collection('users').doc(docId).get();
      var oldUserEmail = data['email'];
      await auth
          .signInWithEmailAndPassword(email: oldUserEmail, password: password)
          .onError(
            (error, stackTrace) => throw "Email or Password is incorrect",
          );
      await firestore.collection('users').doc(docId).update({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      }).onError(
        (error, stackTrace) => throw ("Update Failed"),
      );
      auth.currentUser!.updateEmail(email).onError(
            (error, stackTrace) => throw ("Update Email Failed"),
          );

      return {
        "code": 200,
        "message": "Profile Updated Successfully",
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  updateProfileEmailAndPicture(
    String firstName,
    String lastName,
    String email,
    String password,
    File picture,
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
      var oldUserEmail = data['email'];
      await auth
          .signInWithEmailAndPassword(email: oldUserEmail, password: password)
          .onError(
            (error, stackTrace) => throw "Email or Password is incorrect",
          );

      //Deleting Old Image.
      var oldPictureUrl = data['ProfilePicture'];
      firebase_storage.FirebaseStorage.instance
          .refFromURL(oldPictureUrl)
          .delete();

      //Uploading New Image.
      String fileName = Path.basename(picture.path);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(picture);
      await uploadTask.whenComplete(() => null);
      String uploadedImageUrl = await ref.getDownloadURL();
      prefs.setString("IMAGE", uploadedImageUrl);

      //Updating User Data in Firestore.
      await firestore.collection('users').doc(docId).update({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "ProfilePicture": uploadedImageUrl,
      }).onError(
        (error, stackTrace) => throw "Update Profile Failed",
      );

      //Updating User Email in Firebase Auth.
      auth.currentUser!.updateEmail(email).onError(
            (error, stackTrace) => throw ("Update Email Failed"),
          );

      return {
        "code": 200,
        "message": "",
      };
    } on Exception catch (e) {
      var prefs = await SharedPreferences.getInstance();
      var imageUrl = prefs.getString("IMAGE");
      if (imageUrl != null) {
        firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl).delete();
      }
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  updateProfileNameAndPicture(
    String firstName,
    String lastName,
    File picture,
  ) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;

      //Deleting Old Image.
      var userData = await firestore.collection('users').doc(docId).get();
      var oldPictureUrl = userData['ProfilePicture'];
      firebase_storage.FirebaseStorage.instance
          .refFromURL(oldPictureUrl)
          .delete();

      //Uploading New Image.
      String fileName = Path.basename(picture.path);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(picture);
      await uploadTask.whenComplete(() => null);
      String uploadedImageUrl = await ref.getDownloadURL();
      prefs.setString("IMAGE", uploadedImageUrl);

      //Updating User Data in Firestore.
      await firestore.collection('users').doc(docId).update({
        "firstName": firstName,
        "lastName": lastName,
        "ProfilePicture": uploadedImageUrl,
      }).onError(
        (error, stackTrace) => throw "Update Profile Failed",
      );

      return {
        "code": 200,
        "message": "",
      };
    } on Exception catch (e) {
      var prefs = await SharedPreferences.getInstance();
      var imageUrl = prefs.getString("IMAGE");
      if (imageUrl != null) {
        firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl).delete();
      }
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  followUser(String userDocID) async {
    try {
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
      var data = await firestore.collection('users').doc(docId).get();
      List following = data['following'];
      int followingCount = data['followingCount'];
      var otherUserData =
          await firestore.collection('users').doc(userDocID).get().onError(
                (error, stackTrace) => throw "User Not Found",
              );
      List followers = otherUserData['followers'];
      int followersCount = otherUserData['followersCount'];
      followers.add(auth.currentUser!.uid);
      following.add(otherUserData['userID']);
      await firestore.collection('users').doc(docId).update({
        "following": following,
        "followingCount": followingCount + 1,
      });
      await firestore.collection('users').doc(userDocID).update({
        "followers": followers,
        "followersCount": followersCount + 1,
      });
      await firestore.collection('notifications').add({
        "userID": otherUserData['userID'],
        "notificationTitle":
            '${data['firstName']} ${data['lastName']} Liked Your Post',
        "userImage": data['ProfilePicture'],
        "timeStamp": DateTime.now(),
      });
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  unFollowUser(String userDocID) async {
    try {
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
      var data = await firestore.collection('users').doc(docId).get();
      List following = data['following'];
      int followingCount = data['followingCount'];
      var otherUserData =
          await firestore.collection('users').doc(userDocID).get().onError(
                (error, stackTrace) => throw "User Not Found",
              );
      List followers = otherUserData['followers'];
      int followersCount = otherUserData['followersCount'];
      followers.remove(auth.currentUser!.uid);
      following.remove(otherUserData['userID']);
      await firestore.collection('users').doc(docId).update({
        "following": following,
        "followingCount": followingCount - 1,
      });
      await firestore.collection('users').doc(userDocID).update({
        "followers": followers,
        "followersCount": followersCount - 1,
      });
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  followSchool(String schoolDocID) async {
    try {
      var schoolData =
          await firestore.collection('schools').doc(schoolDocID).get();
      List followers = schoolData['followers'];
      followers.add(auth.currentUser!.uid);
      await firestore.collection('schools').doc(schoolDocID).update({
        'followers': followers,
      });
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

  unFollowSchool(String schoolDocID) async {
    try {
      var schoolData =
          await firestore.collection('schools').doc(schoolDocID).get();
      List followers = schoolData['followers'];
      followers.remove(auth.currentUser!.uid);
      await firestore.collection('schools').doc(schoolDocID).update({
        'followers': followers,
      });
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
}
