import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class Behavioural2 extends StatelessWidget {
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
          "Behavioural",
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
                  "The Importance of Social Skills Therapy for Autism",
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
                  "One of the most significant problems for people on the autism spectrum is difficulty in social interaction. The level of difficulty can be very severe (as it usually is for people with no spoken language) or relatively mild.1 Even mild difficulties with social communication, however, can lead to major problems with relationships, school, and employment. Social Skills Affected by Autism In some cases, people with autism lack very basic social skills. They may find it very difficult (or even impossible) to make eye contact, ask and answer questions, or respond appropriately with please and thank you.1﻿ These basic skills, while they are not enough to support a meaningful relationship, are important tools for self-advocacy and for interacting with any member of the community. In other cases, basic communication skills are intact, but there are gaps in understanding others' thoughts and feelings and responding appropriately. These issues, very often, are the result of not knowing what another person might be thinking.2﻿ Most people can observe others and guess, through a combination of tone and body language, what's really going on. In general, without help and training, autistic people (even those with very high intelligence) can't.3 This mind blindness can lead even the highest-functioning person on the autism spectrum to make social blunders that cause all kinds of problems. Without knowing why, a person on the autism spectrum can hurt feelings, ask inappropriate questions, act oddly or generally open themselves up to hostility, teasing, bullying, and isolation.4﻿ Social Skills Therapist As autism spectrum disorders have become more and more common, a sort of industry has grown up around teaching social skills to both children and adults. There is no such thing as an association of social skills therapists, nor is there an official certification in the field. Thus, social skills practitioners come from a wide range of backgrounds and training.5 In general, social skills therapists are social workers, psychologists, occupational therapists and speech/language therapists who specialize in working with autistic people. Over time, they have developed or learned techniques to build social interaction skills ranging from basic skills (such as making eye contact) to complex and subtle skills (like asking for a date).6﻿ In some cases, social skills therapists have received training and certification in a particular therapeutic method. Individual therapist/researchers, including Carol Gray, Brenda Myles, and Michelle Garcia Winner, have developed programs and materials that can be useful in teaching, practicing, and generalizing social skills. In recent years,do it yourself social skills teaching tools for parents and adults on the autism spectrum have hit the market. These generally take the form of books and videos modeling different types of interactions, along with hints and tips for doing it right. Drama therapists also work on social skills through literally scripting scenarios and/or improving and critiquing practice interactions.7 How Social Skills Therapists Help People With Autism Since there is no single official certification for social skills therapists, techniques vary. In a school setting, social skills therapy may consist of group activities (usually games and conversation) with autistic and typically developing peers.8 Groups may be overseen by school psychologists or social workers and may be held in the classroom, lunchroom or playground. Generally speaking, school social skills groups focus on game playing, sharing, and conversation. Out-of-school social skills groups are similar in style but are paid for privately (medical insurance is unlikely to cover such programs). Children are grouped by age and ability and may make use of specific social skills curricula as developed by well-established practitioners of social skills therapy. Drama therapy, a variation on social skills therapy, is somewhat unusual but where it's offered, it has the potential to be both fun and educational. Video modeling, video critiques of interactions, group therapy, and other approaches may also be available in your area and are especially appropriate for teens and adults. Typical cognitive therapy with a psychologist or psychiatrist may also be helpful.",
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
