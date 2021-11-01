import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/user/home_page.dart';
import 'package:autism101/model/Movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  final Movie movie;
  const MovieScreen({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            movie.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w300
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              Image.asset(
                movie.image,
                height: deviceHeight! * 0.7,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: deviceHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black,Colors.transparent],
                    stops: [0.3,0.9],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0,top: deviceHeight! * 0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Watch the movie',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0
                          ),
                        ),
                        RawMaterialButton(
                            onPressed: (){

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(CupertinoIcons.play_fill,color: Colors.white,size: 30,),
                        ),
                          shape: CircleBorder(),
                          fillColor: Colors.blue,
                        ),
                      ],
                    ),
                    K_vSpace,
                    Text(
                      'Brief',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w300
                      ),
                    ),

                    K_vSpace,
                    Text(
                      movie.brief,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    K_vSpace,
                    SizedBox(width: deviceWidth! * 0.5,child: Container(color: Colors.grey,height: 0.3,),),
                    K_vSpace,
                    Text(
                      'Age rate',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    K_vSpace,
                    Text(
                      movie.ageRate,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    K_vSpace,
                    SizedBox(width: deviceWidth! * 0.5,child: Container(color: Colors.grey,height: 0.3,),),
                    K_vSpace,
                    Text(
                      'Actors',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    K_vSpace,
                    Text(
                      movie.actors,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    K_vSpace
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
