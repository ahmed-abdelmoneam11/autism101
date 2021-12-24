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

class EditPost extends StatefulWidget {
  final String post;
  final bool imageFlag;
  final postImageUrl;
  EditPost({
    required this.post,
    required this.imageFlag,
    this.postImageUrl,
  });
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  late ProfileBloc profileBloc;
  late PostsBloc postsBloc;
  late TextEditingController _postController;
  late File? newImage;
  List<String> options = ['Take photo', 'Choose existing photo'];
  String firstName = '';
  String lastName = '';
  String profilePictureUrl =
      'https://firebasestorage.googleapis.com/v0/b/autism101-4d85b.appspot.com/o/demoUserImage.jpg?alt=media&token=1bbf3bd7-017a-4299-becb-8228a29d796e';
  bool hasNewImage = false;

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
    _postController = TextEditingController(text: widget.post);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: _postController.text != widget.post || hasNewImage
                ? editPost
                : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                _postController.text != widget.post || hasNewImage
                    ? Colors.lightBlue
                    : Colors.grey,
              ),
            ),
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
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
          onPressed: () => Navigator.pop(context),
        ),
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
              } else if (state is DeletePostErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is EditPostContentAndImageErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is EditPostContentErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is EditPostImageErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is DeletePostSuccessState ||
                  state is EditPostContentAndImageSuccessState ||
                  state is EditPostContentSuccessState ||
                  state is EditPostImageSuccessState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
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
                    widget.imageFlag
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
                                  image: hasNewImage
                                      ? DecorationImage(
                                          image: FileImage(
                                            newImage!,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : DecorationImage(
                                          image: NetworkImage(
                                            widget.postImageUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              hasNewImage
                                  ? Positioned(
                                      top: 8.0,
                                      right: 8.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            hasNewImage = false;
                                          });
                                        },
                                        child: Icon(
                                          Icons.remove_circle,
                                          size: 35.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            //Floating Pop Up.
            Container(
              padding: EdgeInsets.only(right: 5.0, bottom: 5.0),
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
      floatingActionButton: FloatingActionButton(
        onPressed: deletePost,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30.0,
        ),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
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
      newImage = File(pickedFile!.path);
      hasNewImage = true;
    });
  }

  Future takeImageForProfil() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      newImage = File(pickedFile!.path);
      hasNewImage = true;
    });
  }

  Future deletePost() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Toast.show("No internet connection !", context,
          duration: Toast.LENGTH_LONG);
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            elevation: 1.0,
            title: Text(
              "Delete Post",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21.0,
                height: 1.3,
              ),
            ),
            content: Text(
              "Are you sure? deleting post will remove this post permanently from your posts",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
                height: 1.3,
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    height: 1.3,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    height: 1.3,
                  ),
                ),
                onPressed: () {
                  postsBloc.add(
                    DeletePost(
                      post: widget.post,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future editPost() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Toast.show("No internet connection !", context,
          duration: Toast.LENGTH_LONG);
    } else if (_postController.text != widget.post && hasNewImage) {
      postsBloc.add(
        EditPostContentAndImage(
          oldPost: widget.post,
          newPost: _postController.text,
          newImage: newImage!,
        ),
      );
    } else if (_postController.text != widget.post && hasNewImage == false) {
      postsBloc.add(
        EditPostContent(
          oldPost: widget.post,
          newPost: _postController.text,
        ),
      );
    } else if (_postController.text == widget.post && hasNewImage) {
      postsBloc.add(
        EditPostImage(oldPost: widget.post, newImage: newImage!),
      );
    }
  }
}
