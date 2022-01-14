import 'package:flutter/material.dart';
import 'package:autism101/Constants.dart';

class Areas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () => Navigator.pop(context),
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
                "Areas are that may be affected by autism",
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
              'assets/images/Areasarethatmaybeaffectedbyautism2.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Communication",
                  style: MostImportatnTopicsHeaderStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "language develops slowly or not at all; uses words without attaching the usual meaning to them; communicates with gestures instead of words; short attention span.",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Social Interaction",
                  style: MostImportatnTopicsHeaderStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "spends time alone rather than with others; shows little interest in making friends; less responsive to social cues such as eye contact or smiles.",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Sensory Impairment",
                  style: MostImportatnTopicsHeaderStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "may have sensitivities in the areas of sight, hearing, touch, smell, and taste to a greater or lesser degree.",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Play",
                  style: MostImportatnTopicsHeaderStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "lack of spontaneous or imaginative play; does not imitate others' actions; does not initiate pretend games.",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Behaviors",
                  style: MostImportatnTopicsHeaderStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "may be overactive or very passive; throws tantrums for no apparent reason; shows an obsessive interest in a single item, idea, activity, or person; apparent lack of common sense; may show aggression to others or self; often has difficulty with changes in routine.",
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
