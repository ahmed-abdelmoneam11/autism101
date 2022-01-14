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
    var prefs = await SharedPreferences.getInstance();
    try {
      // var userEmail = auth.currentUser!.email;
      // if (userEmail == null) {
      //   throw "User Not Found";
      // }
      //Getting Current user doc id.
      var token = prefs.getString("TOKEN");
      if (token == null) {
        throw "User Not Found";
      }
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: token)
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

  searchUser(String query) async {
    try {
      var queryResult = firestore
          .collection('users')
          .where('firstName', isEqualTo: query)
          .snapshots();
      if (await queryResult.isEmpty) {
        return {
          "code": 200,
          "data": "No Users Matched This Name!",
        };
      }
      return {
        "code": 200,
        "data": queryResult,
      };
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
    var prefs = await SharedPreferences.getInstance();
    try {
      // var userEmail = auth.currentUser!.email;
      // if (userEmail == null) {
      //   throw "User Not Found";
      // }
      var token = prefs.getString("TOKEN");
      if (token == null) {
        throw "User Not Found";
      }

      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: token)
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
    var prefs = await SharedPreferences.getInstance();
    try {
      // var userEmail = auth.currentUser!.email;
      // if (userEmail == null) {
      //   throw "User Not Found";
      // }
      var token = prefs.getString("TOKEN");
      if (token == null) {
        throw "User Not Found";
      }
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: token)
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
      var token = prefs.getString("TOKEN");
      if (token == null) {
        throw "User Not Found";
      }
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: token)
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
      // var userEmail = auth.currentUser!.email;
      // if (userEmail == null) {
      //   throw "User Not Found";
      // }
      var token = prefs.getString("TOKEN");
      if (token == null) {
        throw "User Not Found";
      }
      var queryResult = await firestore
          .collection('users')
          .where('userID', isEqualTo: token)
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
}
