import 'package:flutter/material.dart';
import 'package:autism101/Constants.dart';

class Types extends StatelessWidget {
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
                "Types of Autism",
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
              'assets/images/typesofautism.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Healthcare professionals defined the four types of autism as:",
                  style: MostImportatnTopicsHeaderStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "- autism spectrum disorder (ASD)\n- Asperger's syndrome\n- childhood disintegrative disorder\n- pervasive developmental disorder-not otherwise specified",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "However, the American Psychiatric Association revised their Diagnostic and Statistical Manual of Mental Disorders (DSM-5) in 2013, which did not include these four subtypes of autism. They now all fall under the one umbrella term of ASD.",
                  style: MostImportatnTopicsHeaderSubStyle,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                  color: Colors.black,
                  indent: 2.0,
                  endIndent: 2.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Autism Spectrum Disorder (ASD):",
                  style: MostImportatnTopicsTitleStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "ASD is an umbrella term that includes a range of neurodevelopmental features. Autism is not a disease, but it can have a significant impact on a person's life. Its effects can vary widely. Some people will need lifelong support, while others can live and work independently. In some cases, the features of the condition may be present from infancy. In others, the signs may become more obvious as the individual becomes older.",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Parents or caregivers may notice that a young child:",
                  style: MostImportatnTopicsHeaderSubStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "- does not babble by the age of 12 months or produce words by 16 months\n- does not respond when people talk to them but reacts to other sounds\n- does not make eye contact\n- lines up toys or objects excessively\n- does not want to be cuddled\n- does not play with others or play make-believe games",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "An older child may:",
                  style: MostImportatnTopicsHeaderSubStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "- have difficulty starting conversations\n- have difficulty making friends and interacting with others\n- use repetitive or atypical language\n- be uncomfortable with changes to their routine\n- be extremely passionate about specific topics or objects",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Features",
                  style: MostImportatnTopicsHeaderSubStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "ASD can affect a person's way of perceiving the world. The person may be hypersensitive to some stimuli, such as light, sound, and taste, leading to the overstimulation of one or more senses. This is called sensory overload.",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "It can make everyday experiences, such as going to a shopping mall, confusing and overwhelming.",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Other people may notice  that the person with ASD has:",
                  style: MostImportatnTopicsHeaderSubStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
