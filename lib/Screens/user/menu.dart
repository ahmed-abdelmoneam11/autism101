// import 'package:autism101/Screens/school/school_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/profile_bloc.dart';
import 'package:autism101/BlocEvents/profile_bloc_events.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/Screens/user/profile_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_menu_items.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late ProfileBloc profileBloc;
  String firstName = '';
  String lastName = '';
  String email = '';
  String profilePictureUrl =
      'https://firebasestorage.googleapis.com/v0/b/autism101-4d85b.appspot.com/o/demoUserImage.jpg?alt=media&token=1bbf3bd7-017a-4299-becb-8228a29d796e';

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(GetProfileDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: BlocListener<ProfileBloc, ProfileState>(
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
            email = state.email;
            profilePictureUrl = state.profilePictureUrl;
          });
        }
      },
      child: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[
            /*User Account Drawer Header*/
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.indigo.shade900,
                        Colors.black,
                      ],
                      stops: [
                        0.3,
                        0.9
                      ]),
                ),
                accountName: TextButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      '$firstName $lastName',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                accountEmail: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    email,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11.0,
                    ),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                    radius: 200,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          profilePictureUrl,
                          height: 500.0,
                          width: 500.0,
                          fit: BoxFit.cover,
                        ))),
              ),
            ),
            MyMenuItems(),
          ],
        ),
      ),
    ));
  }
}
