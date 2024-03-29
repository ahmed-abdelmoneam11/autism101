// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:io';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/profile_bloc.dart';
import 'package:autism101/BlocEvents/profile_bloc_events.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocEvents/posts_bloc_events.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/home_screen.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> options = ['Take photo', 'Choose existing photo'];
  late ProfileBloc profileBloc;
  late PostsBloc postsBloc;
  TextEditingController _postController = TextEditingController();
  late File _image;
  bool hasImage = false;
  String firstName = '';
  String lastName = '';
  String profilePictureUrl =
      'https://firebasestorage.googleapis.com/v0/b/autism101-4d85b.appspot.com/o/demoUserImage.jpg?alt=media&token=1bbf3bd7-017a-4299-becb-8228a29d796e';

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(
      GetProfileDataEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // ignore: deprecated_member_use
          RaisedButton(
            textColor: Colors.black,
            child: Text(
              "Post",
            ),
            onPressed: addPost,
          ),
        ],
        shape: appBarShape,
        title: Text(
          'Create post',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is GetProfileDataErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error,
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is GetProfileDataSuccessState) {
                setState(() {
                  firstName = state.firstName;
                  lastName = state.lastName;
                  profilePictureUrl = state.profilePictureUrl;
                });
              }
            },
          ),
          BlocListener<PostsBloc, PostsState>(
            listener: (context, state) {
              if (state is PostsLodingState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: <Widget>[
                        CircularProgressIndicator(
                          color: Colors.lightBlue,
                        ),
                        Text("  Loading...")
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is AddPostErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is AddPostSuccessState) {
                Navigator.pop(context);
              }
            },
          ),
        ],
        child: Stack(
          children: [
            //Screen Body.
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    K_vSpace,
                    //User Data.
                    Row(
                      children: <Widget>[
                        ///image of the owner of the post//////////////////////
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              profilePictureUrl,
                              height: 50.0,
                              width: 50.0,
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$firstName $lastName',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    //Post Text Field.
                    TextField(
                      maxLines: 5,
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        hintText: "What's on your mind?",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      controller: _postController,
                    ),
                    //Post Image.
                    hasImage
                        ? Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  10.0,
                                ),
                                width: 400.0,
                                height: 350.0,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8.0,
                                right: 8.0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      hasImage = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_circle,
                                    size: 35.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            //Floating Pop Up.
            Container(
              padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 80.0,
                  width: 80.0,
                  child: floatingPopup(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget floatingPopup() => PopupMenuButton(
        itemBuilder: (context) {
          return options.map((choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(
                choice,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                  color: Colors.black,
                  height: 1.0,
                ),
              ),
            );
          }).toList();
        },
        onSelected: (e) => {
          if (e == options[0])
            {
              takeImageForProfil(),
            }
          else if (e == options[1])
            {
              chooseFileForProfil(),
            },
        },
        icon: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: ShapeDecoration(
              color: Colors.blue,
              shape: StadiumBorder(
                side: BorderSide(color: Colors.white, width: 2),
              )),
          child: Icon(
            CupertinoIcons.photo_on_rectangle,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      );

  Future chooseFileForProfil() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      hasImage = true;
    });
  }

  Future takeImageForProfil() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile!.path);
      hasImage = true;
    });
  }

  Future addPost() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Toast.show("No internet connection !", context,
          duration: Toast.LENGTH_LONG);
    } else if (_postController.text.isEmpty) {
      Toast.show("Please enter your post", context,
          duration: Toast.LENGTH_LONG);
    } else if (hasImage == true) {
      postsBloc.add(
        AddPostWithImage(
          post: _postController.text,
          postImage: _image,
        ),
      );
    } else {
      postsBloc.add(
        AddPost(
          post: _postController.text,
        ),
      );
    }
  }
}
