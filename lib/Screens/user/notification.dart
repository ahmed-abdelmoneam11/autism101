import 'package:autism101/Constants.dart';
import 'package:autism101/CustomWidgets/NotificationContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyNotification extends StatefulWidget {
  @override
  _MyNotificationState createState() => _MyNotificationState();
}

List<String> contents = ['sdsds'];

class _MyNotificationState extends State<MyNotification> {
  ///notification screen
  @override
  Widget build(BuildContext context) {
    return showPageContent();
  }
}

showPageContent(){

  if(contents.length == 0)
    return Center(
      child: Text(
        'No Notifications',
        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18.0,color: Colors.black),
      ),
    );
  else
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23.0),),
            K_vSpace,
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: contents.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: NotificationContainer(
                      userImage: 'assets/images/ibrahim2.png',
                      userName: 'Ibrahim shawky',
                      notiContent: contents[index],
                    ),
                  );
                })
          ],
        ),
      ),
    );
}
