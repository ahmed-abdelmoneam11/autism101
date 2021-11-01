import 'package:autism101/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FollowerContainer extends StatelessWidget {

  final userImage;
  final userName;

  const FollowerContainer({Key? key,this.userImage,this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0,left: 3.0,right: 3.0),
      child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: shadow,
          ),
          child: Row(

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
              Expanded(child: Container()),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Follow',
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Massage',
                  )),
            ],
          )
      ),
    );
  }
}
