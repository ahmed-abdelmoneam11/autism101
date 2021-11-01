import 'dart:io';

import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/school/school_profile.dart';
import 'package:autism101/Screens/user/home_page.dart';
import 'package:autism101/Screens/user/home_screen.dart';
import 'package:autism101/model/posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddProduct extends StatefulWidget {
  ///her is the dart code where take the data from post module and put it in profile user screen

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var titleController = TextEditingController();

  Builder buildDialogItem(
      BuildContext context, String text, IconData icon, ImageSource src) {
    return Builder(
      builder: (innerContext) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(text),
          onTap: () {
            context.read<Products>().getImage(src);
            Navigator.of(innerContext).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    File? _image = Provider.of<Products>(context, listen: true).image;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<Products>(
            builder: (ctx, value, _) => RaisedButton(
              textColor: Colors.black,
              child: Text("Post",),
              onPressed: () async {
                if (titleController.text.isEmpty && _image == null) {
                  Toast.show("Please enter your post", ctx,
                      duration: Toast.LENGTH_LONG);
                }
                else if (_image == null) {
                  Toast.show("Please select an image", ctx,
                      duration: Toast.LENGTH_LONG);
                }
                else {
                  try {
                    value.add(
                      title: titleController.text,
                    );
                    await Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => HomeScreen()));
                  } catch (e) {
                    Toast.show("Please enter a valid price", ctx,
                        duration: Toast.LENGTH_LONG);
                    print(e);
                  }
                }
              },
            ),
          ),
        ],
        shape: appBarShape,
        title: Text('Create post',style: TextStyle(color: Colors.black,),),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () => Navigator.pop(context)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          var ad = AlertDialog(
            title: Text("Choose Picture from:"),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  Divider(color: Colors.black),
                  buildDialogItem(context, "Camera",
                      Icons.add_a_photo_outlined, ImageSource.camera),
                  SizedBox(height: 10),
                  buildDialogItem(context, "Gallery",
                      Icons.image_outlined, ImageSource.gallery),
                ],
              ),
            ),
          );
          showDialog(builder: (context) => ad, context: context);
        },
        child: Icon(
          CupertinoIcons.photo_on_rectangle,
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              K_vSpace,
              Row(
                children: <Widget>[
                  ///image of the owner of the post//////////////////////
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/ibrahim.png',
                        height: 50.0,
                        width: 50.0,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(width: 10,),
                  Text(
                    ('Ibrahim Shawki'),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              TextField(
                maxLines: 10,
                style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w300
                ),
                decoration: InputDecoration(
                     hintText: "What's on your mind?",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                ),
                controller: titleController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
