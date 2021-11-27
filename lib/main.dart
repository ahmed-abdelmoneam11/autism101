// import 'package:autism101/Screens/admin/admin_home.dart';
import 'package:autism101/Screens/user/add_posts.dart';
// import 'package:autism101/Screens/user/alarm/enums.dart';
// import 'package:autism101/Screens/user/home_page.dart';
import 'package:autism101/Screens/user/home_screen.dart';
// import 'package:autism101/model/menu_info.dart';
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
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/LoginForm.dart';
import 'Screens/ParentAccount.dart';
import 'Screens/ParentAccount2.dart';
import 'Screens/Register.dart';
import 'Screens/school/SchoolAccount.dart';
// import 'model/agendas.dart';
// import 'model/posts.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // var initializationSettingsAndroid = AndroidInitializationSettings('logo');
  // var initializationSettingsIOS = IOSInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     onDidReceiveLocalNotification:
  //         (int id, String title, String body, String payload) async {});
  // var initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: ' + payload);
  //   }
  // });
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
      ],
      child: MyApp(),
    ),
  );
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider<Products>(
  //         create: (_) => Products(),
  //       ),
  //       ChangeNotifierProvider<Agendas>(
  //         create: (_) => Agendas(),
  //       ),
  //       ChangeNotifierProvider<MenuInfo>(
  //         create: (_) => MenuInfo(MenuType.alarm),
  //       )
  //     ],
  //     child: MyApp(),
  //   ),
  // );
}

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var token;
  void initializePreferences() async {
    var prefs = await SharedPreferences.getInstance();
    // prefs.remove("TOKEN");
    setState(() {
      token = prefs.getString("TOKEN");
    });
  }

  @override
  void initState() {
    initializePreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myThemeData,
      home: token != null ? HomeScreen() : Loginform(),
      //
      // Admin_Home(),
      routes: {
        '/Register': (ctx) => Register(),
        '/SchoolAccount': (ctx) => SchoolAccount(),
        '/loginform': (ctx) => Loginform(),
        '/ParentAccount': (ctx) => ParentAccount(),
        '/parentAccount2': (ctx) => ParentAccount2(),
        '/AddPost': (ctx) => AddProduct(),
      },
    );
  }
}
