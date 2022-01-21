import 'package:autism101/Screens/user/event.dart';
import 'package:autism101/Screens/user/people_youMayKnow.dart';
import 'package:autism101/Screens/user/progress.dart';
import 'package:autism101/Screens/user/school_category.dart';
import 'favorite_list_screen.dart.dart';
import 'package:autism101/Screens/LoginForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/auth_bloc.dart';
import 'package:autism101/BlocEvents/auth_bloc_events.dart';
import 'package:autism101/BlocStates/auth_bloc_state.dart';
import 'package:autism101/flush_bar.dart';
import 'Behavioral_agenda.dar.dart';
import 'Inspiring.dart';
import 'Movie.dart';
// import 'MovieScreen.dart';

class MyMenuItems extends StatefulWidget {
  @override
  State<MyMenuItems> createState() => _MyMenuItemsState();
}

class _MyMenuItemsState extends State<MyMenuItems> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //color: Colors.black;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LodingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("  Loading...")
                ],
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is SignOutSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Loginform(),
            ),
            (route) => false,
          );
        }
      },
      child: Column(
        ///Scroll Bar where user can enter Event and Favorite Lise and so on
        children: <Widget>[
          //Events
          ListTile(
            title: Text('Events'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Events(),
                ),
              );
            },
            leading: const Icon(Icons.event),
          ),
          //Progress
          ListTile(
            title: Text('Progress'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Progress(),
                ),
              );
            },
            leading: const Icon(Icons.self_improvement),
          ),
          //Favorite List
          ListTile(
            title: Text('Favorite List '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteList(),
                ),
              );
            },
            leading: const Icon(Icons.favorite_border),
          ),
          //Movies
          ListTile(
            title: Text('Movies'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Movies(),
                ),
              );
            },
            leading: const Icon(Icons.movie),
          ),
          //Behavioral Agenda
          ListTile(
            title: Text('Behavioral Agenda'),
            leading: const Icon(Icons.insert_drive_file_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyAgendaPage(),
                ),
              );
            },
          ),
          //People you may know
          ListTile(
            title: Text('People you may know'),
            leading: const Icon(Icons.people),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PeopleYouMayKnow(),
                ),
              );
            },
          ),
          //Contact with School
          ListTile(
            title: Text('Contact with School'),
            leading: const Icon(Icons.home_work_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => School_Category(),
                ),
              );
            },
          ),
          //Inspiring people
          ListTile(
            title: Text('Inspiring people'),
            leading: const Icon(Icons.emoji_people_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Inspiring(),
                ),
              );
            },
          ),
          //Logout
          ListTile(
            title: Text('Logout'),
            leading: Transform.rotate(
              angle: 15.7,
              child: const Icon(Icons.login_rounded),
            ),
            onTap: signOut,
          ),
        ],
      ),
    );
  }

  void signOut() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              elevation: 1.0,
              title: Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                  height: 1.3,
                ),
              ),
              content: Text(
                "Are you sure? signing out will remove all Autism 101 data from this device.",
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
                    authBloc.add(SignOutButtonPressed());
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }
}
