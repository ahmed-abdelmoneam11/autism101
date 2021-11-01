import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///the module of posts

class Product {
  final int id;
  final String title;
  File? image;

  Product({
     required this.id,
     required this.title,
     this.image,
  });
}

class Products with ChangeNotifier {
  List<Product> productsList = [];
   File? image;

  void add({required String title}) {
    productsList.add(Product(id: 1, title: title, image: image));
    notifyListeners();
  }
/*
  void deleteImage() {
    image = null;
  }
*/
  Future getImage(ImageSource src) async {
    final pickedFile = await ImagePicker().getImage(source: src);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
      print('Image selected.');
    } else {
      print('No image selected.');
    }
  }
}
