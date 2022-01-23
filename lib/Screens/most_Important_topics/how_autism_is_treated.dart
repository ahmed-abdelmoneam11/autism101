import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class HowAutismIsTreated extends StatelessWidget {
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
                "How Autism Is Treated",
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
              'assets/images/HowAutismIsTreated.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReadMoreText(
              "Every person with an autism spectrum disorder (ASD) has different needs, so the best treatment options will always be individual. Autism cannot be cured, so the goal is to help a person gain and hone skills, and better navigate daily life, including school, work, relationships, etc. This might include, but is certainly not limited to, physical therapy, behavioral therapy, speech therapy, and prescription medications. This is an area where there are many unsupported treatment claims, so it can be tricky to navigate. As with everything, always consider the source of any information you're receiving and work closely with your or your child's doctor to determine what treatments should be tried, how they're working, and what changes might need to be considered. Specialized Therapies In the U.S., children under school age who have been diagnosed with an autism spectrum disorder are eligible for early intervention services (EI).1﻿ These are free, in-home and/or preschool-based programs that include supported educational programs and therapies. If your child is older than 5 or 6, similar treatments will be offered through your school district and other agencies. If your child is not offered these services, it's up to you to ask why. Most of the time, your child will be provided with at least the following treatments at some level (free of charge): Speech therapy: If your child is non-verbal, this will likely focus on basic communication skills; if they are verbal, it may focus more on speech pragmatics (the ability to use language in a social setting). Occupational therapy: This can range from handwriting and sensory integration to play and social skills therapy, depending on the therapist, need, and the amount of time available. Physical therapy: Ideally, a physical therapist will work on gross motor skills in a social setting such as gym or recess. Social skills therapy: Usually offered by a speech or occupational therapist, social skills therapy teaches children with autism (usually in group situations) how to interact appropriately by sharing, collaborating, taking turns, asking and answering questions, and so forth. Your child may also receive applied behavioral analysis (ABA), either individually or in the context of an autism classroom. It is one of the oldest and most fully researched treatments specifically developed for autism.2﻿ ABA is a very intensive system of reward-based training that focuses on teaching particular skills and behaviors, such as everyday tasks. If any autism-specific therapy is offered by your school and/or covered by your insurance, this will probably be the one. Private Therapy Schools and early intervention programs are very clear that, while they must provide services, they're not required to offer the best services. As such, many parents who have the means often seek additional therapy for their children. If you pursue this, you will need to check on whether any private therapy will be covered by insurance or if you will need to pay out of pocket. Behavioral therapy usually will include ABA, but there are many other forms. Some types, such as pivotal response therapy, may not be available near you or funded by your insurance. Developmental therapies include floortime, SCERTS, and relationship development intervention (RDI). They build from a child's own interests, strengths, and developmental level to increase emotional, social, and intellectual skills. Developmental therapies are often contrasted to behavioral therapies, which are best used to teach specific skills such as shoe tying, tooth brushing, etc. Play therapy and recreational therapy are often grouped with developmental therapies. Prescriptions Medications can help manage autism symptoms and those of related conditions. These medications are prescribed by healthcare providers and are often covered by insurance with a formal diagnosis.",
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
          ),
        ],
      ),
    );
  }
}
