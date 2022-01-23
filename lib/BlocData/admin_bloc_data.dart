import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  addMovie(
    String movieName,
    String movieBrief,
    String movieAgeRate,
    String movieActors,
    String movieUrl,
    File movieImage,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      //Uploading movie Image.
      String fileName = Path.basename(movieImage.path);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(movieImage);
      await uploadTask.whenComplete(() => null).onError(
            (error, stackTrace) => throw ("Failed to upload movie image"),
          );
      String uploadedImageUrl = await ref.getDownloadURL();
      prefs.setString("IMAGE", uploadedImageUrl);

      //Adding new post.
      await firestore.collection('movies').add({
        "name": movieName,
        "brief": movieBrief,
        "ageRate": movieAgeRate,
        "actors": movieActors,
        "url": movieUrl,
        "imageUrl": uploadedImageUrl,
      }).onError(
        (error, stackTrace) => throw ("Failed to add new movie"),
      );
      return {
        "code": 200,
      };
    } on Exception catch (e) {
      if (e.toString() == "Failed to add new movie") {
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

  addInspiring(
    String name,
    String brief,
    String date,
    String autismCase,
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
            (error, stackTrace) => throw ("Failed to upload movie image"),
          );
      String uploadedImageUrl = await ref.getDownloadURL();
      prefs.setString("IMAGE", uploadedImageUrl);

      //Adding new post.
      await firestore.collection('Inspiring').add({
        "name": name,
        "brief": brief,
        "date": date,
        "autismCase": autismCase,
        "imageUrl": uploadedImageUrl,
      }).onError(
        (error, stackTrace) => throw ("Failed to add new inspiring"),
      );
      return {
        "code": 200,
      };
    } on Exception catch (e) {
      if (e.toString() == "Failed to add new inspiring") {
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

  getMovies() async {
    try {
      //Getting Movies.
      var movies = firestore.collection('movies').snapshots();
      if (await movies.isEmpty) {
        throw "No Movies Available";
      }
      return {
        "code": 200,
        "data": movies,
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  getUnVerifiedSchools() async {
    try {
      var schools = firestore
          .collection('schools')
          .where('isVerified', isEqualTo: false)
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

  verifySchool(String webSite) async {
    var schoolQuery = await firestore
        .collection('schools')
        .where('website', isEqualTo: webSite)
        .get();
    var docID = schoolQuery.docs.first.id;
    await firestore.collection('schools').doc(docID).update({
      "isVerified": true,
    });
  }

  getInspiring() async {
    try {
      var inspiring = firestore.collection('Inspiring').snapshots();
      if (await inspiring.isEmpty) {
        throw "No Inspiring Available";
      }
      return {
        "code": 200,
        "data": inspiring,
      };
    } on Exception catch (e) {
      return {
        "code": 400,
        "message": e.toString(),
      };
    }
  }

  deleteUser(String email) async {
    try {
      //Find The Movie to be deleted.
      var userQueryResult = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "User not found",
          );
      var userDocId = userQueryResult.docs.first.id;
      var usersData = await firestore.collection('users').doc(userDocId).get();
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(usersData['ProfilePicture'])
          .delete()
          .onError(
            (error, stackTrace) => throw "Error Deleting User Image",
          );
      await firestore.collection('users').doc(userDocId).delete();
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

  deleteMovie(String movieName) async {
    try {
      //Find The Movie to be deleted.
      var movieQueryResult = await firestore
          .collection('movies')
          .where('name', isEqualTo: movieName)
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Movie not found",
          );
      var movieDocId = movieQueryResult.docs.first.id;
      var moviesData =
          await firestore.collection('movies').doc(movieDocId).get();
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(moviesData['imageUrl'])
          .delete()
          .onError(
            (error, stackTrace) => throw "Error Deleting Movie Image",
          );
      await firestore.collection('movies').doc(movieDocId).delete();
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

  deleteInspiring(String name) async {
    try {
      //Find The Movie to be deleted.
      var movieQueryResult = await firestore
          .collection('Inspiring')
          .where('name', isEqualTo: name)
          .limit(1)
          .get()
          .onError(
            (error, stackTrace) => throw "Inspiring not found",
          );
      var movieDocId = movieQueryResult.docs.first.id;
      var moviesData =
          await firestore.collection('Inspiring').doc(movieDocId).get();
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(moviesData['imageUrl'])
          .delete()
          .onError(
            (error, stackTrace) => throw "Error Deleting Inspiring Image",
          );
      await firestore.collection('Inspiring').doc(movieDocId).delete();
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
