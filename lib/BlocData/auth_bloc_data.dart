import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  static const String apiKey = 'AIzaSyAnuyCBqzMoJudHF0OBgP0CTzgWA-S6bOs';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  signUpForParent(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
    String age,
    String gender,
    File picture,
  ) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      //Creating User.
      var res = await http.post(
        Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey',
        ),
        body: {
          "email": email,
          "password": password,
        },
      );
      Map<String, dynamic> data = json.decode(res.body);
      if (data.containsKey("error") &&
          data['error']['message'] == 'EMAIL_EXISTS') {
        throw ("Email already exist");
      }
      if (data.containsKey("error") &&
          data['error']['message'] == 'MISSING_EMAIL') {
        throw ("Invalid email");
      }
      await auth.signInWithEmailAndPassword(email: email, password: password);

      //Uploading Profile Picture.
      String fileName = Path.basename(picture.path);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(picture);
      await uploadTask.whenComplete(() => null);
      String uploadedImageUrl = await ref.getDownloadURL();
      prefs.setString("IMAGE", uploadedImageUrl);

      //Saving User's Data.
      await firestore.collection('users').add({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "age": age,
        "gender": gender,
        "ProfilePicture": uploadedImageUrl,
        "postsCount": 0,
        "followingCount": 0,
        "followersCount": 0,
        "followers": [],
        "following": [auth.currentUser!.uid],
        "userID": auth.currentUser!.uid,
      }).onError(
        (error, stackTrace) => throw ("Registration Failed"),
      );
      return {
        "code": 200,
      };
    } catch (e) {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await auth.currentUser!.delete();
      var prefs = await SharedPreferences.getInstance();
      var imageUrl = prefs.getString("IMAGE");
      if (imageUrl != null) {
        firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl).delete();
      }
      var queryResult = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
      await firestore.collection('users').doc(docId).delete();
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  signUpForShool(
    String name,
    String phone,
    String webSite,
    String address,
    String password,
    File picture,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      var res = await http.post(
        Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey',
        ),
        body: {
          "email": webSite,
          "password": password,
        },
      );
      Map<String, dynamic> data = json.decode(res.body);
      if (data.containsKey("error") &&
          data['error']['message'] == 'EMAIL_EXISTS') {
        throw ("Email already exist");
      }
      if (data.containsKey("error") &&
          data['error']['message'] == 'MISSING_EMAIL') {
        throw ("Invalid email");
      }
      await auth.signInWithEmailAndPassword(
        email: webSite,
        password: password,
      );

      //Uploading Profile Picture.
      String fileName = Path.basename(picture.path);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(picture);
      await uploadTask.whenComplete(() => null);
      String uploadedImageUrl = await ref.getDownloadURL();
      prefs.setString("IMAGE", uploadedImageUrl);

      await firestore.collection('schools').add({
        "name": name,
        "phone": phone,
        "website": webSite,
        "address": address,
        "imageUrl": uploadedImageUrl,
        "isVerified": false,
        "followers": [],
        "followersCount": 0,
        "eventsCount": 0,
        "schoolID": auth.currentUser!.uid,
      }).onError((error, stackTrace) => throw ("Registration Failed"));
      return {
        "code": 200,
      };
    } catch (e) {
      await auth.signInWithEmailAndPassword(email: webSite, password: password);
      await auth.currentUser!.delete();
      var imageUrl = prefs.getString("IMAGE");
      if (imageUrl != null) {
        firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl).delete();
      }
      var queryResult = await firestore
          .collection('schools')
          .where('website', isEqualTo: webSite)
          .limit(1)
          .get();
      var docId = queryResult.docs.first.id;
      await firestore.collection('schools').doc(docId).delete();
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  signIn(
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {
        "code": 200,
      };
    } catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  signOut() async {
    await auth.signOut();
  }

  sendCode(String email) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  resetPassword(
    String code,
    String newPassword,
  ) async {
    try {
      await auth.confirmPasswordReset(code: code, newPassword: newPassword);
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
