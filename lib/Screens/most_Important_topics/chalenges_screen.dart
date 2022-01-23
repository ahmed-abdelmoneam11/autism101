import 'package:flutter/material.dart';
import 'package:autism101/Constants.dart';

class Chalenges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Center(
              child: Text(
                "Autism chalenges and strengths",
                style: MostImportatnTopicsTitleStyle,
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            width: double.infinity,
            height: 250.0,
            padding: EdgeInsets.all(
              8.0,
            ),
            child: Image.asset(
              'assets/images/AutismChalengesandstrengths.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Signs of ASD",
                  style: MostImportatnTopicsTitleStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "According to the National Institute of Mental Health, early signs of ASD can include:",
                  style: MostImportatnTopicsHeaderSubStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "- little or inconsistent eye contact \n- not sharing enjoyment of objects or activities by pointing or showing things to others \n- difficulty responding to adult attempts to gain attention \n- difficulty with back and forth communication \n- talking at length without gauging the interest of others \n- a flat tone of voice \n- difficulty with perspective-taking \n- sensory sensitivities \n- repeating certain behaviors, words, or phrases \n- intense interests in specific things \n- becoming upset by changes in routine \n- problems sleeping",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                  color: Colors.black,
                  indent: 2.0,
                  endIndent: 2.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "While autistic people may face many challenges, they may also have differences that many would consider strengths. These include:",
                  style: MostImportatnTopicsHeaderSubStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "- superior memory for facts and figures \n- specialist knowledge in topics of interest \n- high level of motivation and enthusiasm in activities of interest, with a drive to share this enjoyment and enthusiasm with others \n- a high degree of accuracy in various tasks \n- innovative approaches to problem solving \n- exceptional attention to detail \n- ability to follow instructions accurately, under appropriate guidance \n- exceptional skills in creative skills \n- ability to see the world from an alternative perspective and therefore offer unique insights \n- a tendency to be nonjudgmental, honest, and loyal in social relationships \n- a unique sense of humor",
                  style: MostImportatnTopicsContentStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
