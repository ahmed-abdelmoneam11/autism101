import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class ProfileApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  getProfileData() async {
    try {
      var userEmail = auth.currentUser!.email;
      if (userEmail == null) {
        throw "User Not Found";
      }
      var data = await firestore.collection('users').doc(userEmail).get();
      return {
        "code": 200,
        "firstName": data['firstName'],
        "lastName": data['lastName'],
        "email": data['email'],
        "ProfilePicture": data['ProfilePicture'],
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }
}
