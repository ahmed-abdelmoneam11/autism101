import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  ) async {
    try {
      var prefs = await SharedPreferences.getInstance();
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
      prefs.setString('TOKEN', data['idToken']);
      var user = await firestore.collection('users').add({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "age": age,
        "gender": gender,
      }).onError((error, stackTrace) => throw ("Registration Failed"));
      prefs.setString("USERID", user.id);
      return {
        "code": 200,
      };
    } catch (e) {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await auth.currentUser!.delete();
      var prefs = await SharedPreferences.getInstance();
      var userDocId = prefs.getString("USERID");
      if (userDocId != null) {
        await firestore.collection('users').doc(userDocId).delete();
      }
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
    var prefs = await SharedPreferences.getInstance();
    try {
      var res = await http.post(
        Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey',
        ),
        body: {
          "email": email,
          "password": password,
        },
      );
      Map<String, dynamic> data = json.decode(res.body);
      if (data.containsKey("error") &&
          data['error']['message'] == 'EMAIL_NOT_FOUND') {
        throw ("The email address or password is incorrect");
      }
      if (data.containsKey("error") &&
          data['error']['message'] == 'INVALID_PASSWORD') {
        throw ("The email address or password is incorrect");
      }
      if (data.containsKey("error") &&
          data['error']['message'] == 'USER_DISABLED') {
        throw ("User not found");
      }
      prefs.setString('TOKEN', data['idToken']);
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
    auth.signOut();
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('TOKEN');
    prefs.remove('USERID');
  }
}
