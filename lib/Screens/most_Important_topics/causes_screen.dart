import 'package:flutter/material.dart';
import 'package:autism101/Constants.dart';

class Causes extends StatelessWidget {
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
                "Causes",
                style: MostImportatnTopicsTitleStyle,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            height: 250.0,
            padding: EdgeInsets.all(
              8.0,
            ),
            child: Image.asset(
              'assets/images/causes.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Researchers are still trying to find out why ASD occurs",
                  style: MostImportatnTopicsTitleStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Factors that may play a role include:",
                  style: MostImportatnTopicsHeaderSubStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "- genetic features \n- environmental factors \n- early disruption of brain growth \n- preterm birth \n- being male, as ASD affects about as many males as females \n- having a twin who is autistic",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Researchers have found no evidence that vaccinations or parenting practices contribute to the condition.",
                  style: MostImportatnTopicsHeaderSubStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
