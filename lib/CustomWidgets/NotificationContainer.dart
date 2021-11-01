import 'package:autism101/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationContainer extends StatelessWidget {

  final userImage;
  final userName;
  final notiContent;

  const NotificationContainer({Key? key,this.userImage,this.userName,this.notiContent,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              CupertinoIcons.delete,
              color: Colors.red,
              size: 30.0,
            ),
            K_hSpace
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: shadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  ///image of the owner of the post//////////////////////
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        userImage,
                        height: 50.0,
                        width: 50.0,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(width: 10,),
                  Text(
                    (userName),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Text(notiContent)
            ],
          )
      ),
    );
  }
}
