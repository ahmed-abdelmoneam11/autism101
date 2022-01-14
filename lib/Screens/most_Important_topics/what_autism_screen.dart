import 'package:flutter/material.dart';
import 'package:autism101/Constants.dart';

class WhatIsAutism extends StatelessWidget {
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
                "What is Autism ?",
                style: MostImportatnTopicsTitleStyle,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            width: double.infinity,
            height: 250.0,
            padding: EdgeInsets.all(
              8.0,
            ),
            child: Image.asset(
              'assets/images/whatisautism.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Autism is a complex developmental disability that typically appears during the first three years of a child's life. It is the result of a neurological disorder that profoundly affects the functioning of the brain. It is estimated to occur in as many as 1 in 500 individuals. Autism is 4 times more prevalent in boys than girls. Its prevalence rate now places it as the 3rd most common developmental disability more common than Down Syndrome. Autism is often referred to as a spectrum disorder, which means that the symptoms of autism can occur in many combinations and may range from mild to severe. Children with autism often look normal, but seem to be withdrawn into their own world.",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Another important concepts we need to comprehend:",
                  style: MostImportatnTopicsHeaderStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Individuals with autism find it hard to communicate with others and relate to the outside world. Aggression and self-injurious behavior may also be present. Other behaviors exhibited may include repeated body.",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "movements (such as rocking and hand flapping), unusual responses to people or attachments to objects and resistance to changes and routines. Individuals with autism may experience sensory problems in the 5 senses of sight, touch, hearing, smell and taste. Although a single cause of autism has not yet been found, recent research links autism to biological or neurological differences in the brain. In many families, there appears to be a pattern of autism or related disability suggesting a genetic basis to the disorder.",
                  style: MostImportatnTopicsContentStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Even though there is no cure for autism, better understanding of the disorder has lead to the development of interventions and coping mechanisms. With the proper intervention, many of the autism behaviors can be positively changed, appearing to the untrained person that the child or adult no longer has autism.",
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
