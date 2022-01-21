// import 'package:autism101/Screens/admin/admin_home.dart';
import 'package:autism101/Screens/splash_screen.dart';
import 'package:autism101/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/auth_bloc.dart';
import 'package:autism101/BlocData/auth_bloc_data.dart';
import 'package:autism101/BlocStates/auth_bloc_state.dart';
import 'package:autism101/Blocs/profile_bloc.dart';
import 'package:autism101/BlocData/profile_bloc_data.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/Blocs/posts_bloc.dart';
import 'package:autism101/BlocData/posts_bloc_data.dart';
import 'package:autism101/BlocStates/posts_bloc_state.dart';
import 'package:autism101/Blocs/events_bloc.dart';
import 'package:autism101/BlocData/events_bloc_data.dart';
import 'package:autism101/BlocStates/events_bloc_state.dart';
import 'package:autism101/Blocs/chatting_bloc.dart';
import 'package:autism101/BlocData/chatting_bloc_data.dart';
import 'package:autism101/BlocStates/chatting_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            InitialState(),
            AuthApi(),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            ProfileInitialState(),
            ProfileApi(),
          ),
        ),
        BlocProvider(
          create: (context) => PostsBloc(
            PostsInitialState(),
            PostsApi(),
          ),
        ),
        BlocProvider(
          create: (context) => EventsBloc(
            EventsInitialState(),
            EventsApi(),
          ),
        ),
        BlocProvider(
          create: (context) => ChatBloc(
            ChatInitialState(),
            ChatApi(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myThemeData,
      home: Splash(),
      //Admin_Home(),
    );
  }
}
