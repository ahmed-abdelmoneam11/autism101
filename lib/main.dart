import 'package:autism101/Screens/admin/admin_home.dart';
import 'package:autism101/Screens/user/add_posts.dart';
import 'package:autism101/Screens/user/alarm/enums.dart';
import 'package:autism101/Screens/user/home_page.dart';
import 'package:autism101/Screens/user/home_screen.dart';
import 'package:autism101/model/menu_info.dart';
import 'package:autism101/utils/theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/LoginForm.dart';
import 'Screens/ParentAccount.dart';
import 'Screens/ParentAccount2.dart';
import 'Screens/Register.dart';
import 'Screens/school/SchoolAccount.dart';
import 'model/agendas.dart';
import 'model/posts.dart';

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
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider<Agendas>(
          create: (_) => Agendas(),
        ),
        ChangeNotifierProvider<MenuInfo>(
          create: (_) => MenuInfo(MenuType.alarm),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myThemeData,
      home:
          // Admin_Home(),
          HomeScreen(),
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
