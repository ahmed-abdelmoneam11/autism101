// import 'package:autism101/Screens/user/character_data.dart';
// import 'package:autism101/Screens/user/characters_screen.dart';
// import 'package:flutter/material.dart';

// class InspiringAdmin extends StatefulWidget {
// // const MyMenuItems({Key? key}) : super(key: key);

//   @override
//   _InspiringAdminState createState() => _InspiringAdminState();
// }

// class _InspiringAdminState extends State<InspiringAdmin> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           drawerScrimColor: Colors.white.withOpacity(0.4),
//           // drawer: MyDrawer(),
//           appBar: AppBar(
//             title: Text('Inspiring People'),
//             backgroundColor: Colors.black54,
//             actions: <Widget>[
//               FlatButton(
//                 textColor: Colors.white,
//                 onPressed: () {},
//                 child: Text("Add New"),
//                 shape:
//                     CircleBorder(side: BorderSide(color: Colors.transparent)),
//               ),
//             ],
//           ),
//           body: Container(
//             child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                     mainAxisExtent: 200,
//                     maxCrossAxisExtent: 300,
//                     childAspectRatio: 3 / 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 20),
//                 padding: EdgeInsets.all(10),
//                 itemCount: person.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Screens(todo: person[index]),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 5.0, // soften the shadow
//                             spreadRadius: 0.5, //extend the shadow
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                             image: AssetImage(person[index].image),
//                             fit: BoxFit.cover),
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           Text(person[index].name,
//                               style: TextStyle(
//                                   fontSize: 17,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold)),
//                           Text(person[index].date,
//                               style:
//                                   TextStyle(fontSize: 15, color: Colors.white))
//                         ],
//                       ),
//                       padding: EdgeInsets.only(top: 155),
//                     ),
//                   );
//                 }),
//           )),
//     );
//   }
// }
