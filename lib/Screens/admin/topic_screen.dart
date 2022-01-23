import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:autism101/Constants.dart';
import 'package:autism101/Screens/most_Important_topics/areas_affected_screen.dart';
import 'package:autism101/Screens/most_Important_topics/chalenges_screen.dart';
import 'package:autism101/Screens/most_Important_topics/causes_screen.dart';
import 'package:autism101/Screens/most_Important_topics/what_autism_screen.dart';
import 'package:autism101/Screens/most_Important_topics/types_screen.dart';
import 'package:autism101/Screens/most_Important_topics/frequently_asked_questions.dart';
import 'package:autism101/Screens/most_Important_topics/how_autism_is_treated.dart';
import 'package:autism101/Screens/most_Important_topics/the_common_misconceptions_of_autism.dart';

class Topics extends StatelessWidget {
  final List imageList = [
    'assets/images/whatisautism.jpg',
    'assets/images/typesofautism.jpg',
    'assets/images/Areasarethatmaybeaffectedbyautism2.jpg',
    'assets/images/AutismChalengesandstrengths.jpg',
    'assets/images/causes.jpg',
    'assets/images/FREQUENTLYASKEDQUESTIONS.jpg',
    'assets/images/HowAutismIsTreated.jpg',
    'assets/images/TheCommonMisconceptionsOfAutism.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Most Important Topics",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Most Important Topics',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50.0,
          ),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              aspectRatio: 5.0,
              height: 200,
              initialPage: 0,
            ),
            items: imageList.map((imageUrl) {
              return GestureDetector(
                onTap: () {
                  if (imageUrl ==
                      'assets/images/Areasarethatmaybeaffectedbyautism2.jpg') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Areas(),
                      ),
                    );
                  } else if (imageUrl ==
                      'assets/images/AutismChalengesandstrengths.jpg') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chalenges(),
                      ),
                    );
                  } else if (imageUrl == 'assets/images/causes.jpg') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Causes(),
                      ),
                    );
                  } else if (imageUrl == 'assets/images/whatisautism.jpg') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WhatIsAutism(),
                      ),
                    );
                  } else if (imageUrl == 'assets/images/typesofautism.jpg') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Types(),
                      ),
                    );
                  } else if (imageUrl ==
                      'assets/images/FREQUENTLYASKEDQUESTIONS.jpg') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FrequentlyAskedQuestions(),
                      ),
                    );
                  } else if (imageUrl ==
                      'assets/images/HowAutismIsTreated.jpg') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HowAutismIsTreated(),
                      ),
                    );
                  } else if (imageUrl ==
                      'assets/images/TheCommonMisconceptionsOfAutism.jpg') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TheCommonMisconceptionsOfAutism(),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
