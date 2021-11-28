import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'home_page.dart';
import 'menu.dart';
import 'notification.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Autism");
  //the bar of home & chat & notification
  List<Widget> _pages = [
    Scaffold(
      body: Center(
        child: Text("Chat"),
      ),
    ),
    HomePage(),
    MyNotification(),
  ];
  //start one which will be home
  int _selectedPageIndex = 1;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  //function which give h=the index of which one of the 3 will display
  void _x1(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
          drawer: MyDrawer(),
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.showBottomSheet(
                    (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        height: double.infinity,
                        color: Colors.transparent,
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Search",
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: Colors.grey,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  CupertinoIcons.search,
                  color: Colors.black,
                ),
              ),
            ],
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Autism101',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0),
            ),
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<PostsBloc, PostsState>(
                listener: (context, state) {
                  if (state is AddPostSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Post Added Successfully",
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else if (state is DeletePostSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Post Deleted Successfully",
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else if (state is DeletePostSuccessState ||
                      state is EditPostContentAndImageSuccessState ||
                      state is EditPostContentSuccessState ||
                      state is EditPostImageSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Post Edited Successfully",
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
            ],
            child: _pages[_selectedPageIndex],
          ),
          //navigation bar which will display the function
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedPageIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: _x1,
            items: [
              ///chat screen will be call her
              BottomNavigationBarItem(
                icon: new Icon(
                  CupertinoIcons.mail,
                  size: 25.0,
                ),
                label: 'Chat',
              ),

              ///home screen will be call her
              BottomNavigationBarItem(
                icon: new Icon(
                  CupertinoIcons.home,
                  size: 25.0,
                ),
                label: 'Home',
              ),

              ///notification screen will be call her
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.bell,
                    size: 25.0,
                  ),
                  label: 'Notifications')
            ],
          ),
        ),
      ),
      onWillPop: () => exitApp(),
    );
  }

  //Exit The Application Programmatically.
  exitApp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Text(
            "Exit Autism 101",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 21.0,
              height: 1.3,
            ),
          ),
          content: Text(
            "Do you want to exit ?",
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
                'Yes',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  height: 1.3,
                ),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            TextButton(
              child: Text(
                'No',
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
          ],
        );
      },
    );
  }
}
