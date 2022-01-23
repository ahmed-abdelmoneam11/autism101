import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class Medical2 extends StatelessWidget {
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
          "Medical",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Text(
                  "Medical info of Autism",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 15.0),
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                  color: Colors.black,
                  indent: 40.0,
                  endIndent: 40.0,
                ),
                SizedBox(height: 20.0),
                ReadMoreText(
                  "How is ASD diagnosed? ASD symptoms can vary greatly from person to person depending on the severity of the disorder. Symptoms may even go unrecognized for young children who have mild ASD or less debilitating handicaps. Autism spectrum disorder is diagnosed by clinicians based on symptoms, signs, and testing according to the Diagnostic and Statistical Manual of Mental Disorders-V, a guide created by the American Psychiatric Association used to diagnose mental disorders. Children should be screened for developmental delays during periodic checkups and specifically for autism at 18- and 24-month well-child visits. Very early indicators that require evaluation by an expert include: no babbling or pointing by age 1 no single words by age 16 months or two-word phrases by age 2 no response to name loss of language or social skills previously acquired poor eye contact excessive lining up of toys or objects no smiling or social responsiveness Later indicators include: impaired ability to make friends with peers impaired ability to initiate or sustain a conversation with others absence or impairment of imaginative and social play repetitive or unusual use of language abnormally intense or focused interest preoccupation with certain objects or subjects inflexible adherence to specific routines or rituals If screening instruments indicate the possibility of ASD, a more comprehensive evaluation is usually indicated. A comprehensive evaluation requires a multidisciplinary team, including a psychologist, neurologist, psychiatrist, speech therapist, and other professionals who diagnose and treat children with ASD. The team members will conduct a thorough neurological assessment and in-depth cognitive and language testing. Because hearing problems can cause behaviors that could be mistaken for ASD, children with delayed speech development should also have their hearing tested. What causes ASD? Scientists believe that both genetics and environment likely play a role in ASD. There is great concern that rates of autism have been increasing in recent decades without full explanation as to why. Researchers have identified a number of genes associated with the disorder. Imaging studies of people with ASD have found differences in the development of several regions of the brain. Studies suggest that ASD could be a result of disruptions in normal brain growth very early in development. These disruptions may be the result of defects in genes that control brain development and regulate how brain cells communicate with each other. Autism is more common in children born prematurely. Environmental factors may also play a role in gene function and development, but no specific environmental causes have yet been identified. The theory that parental practices are responsible for ASD has long been disproved. Multiple studies have shown that vaccination to prevent childhood infectious diseases does not increase the risk of autism in the population.",
                  trimLines: 10,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
