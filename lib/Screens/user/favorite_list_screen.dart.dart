import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    print(auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
