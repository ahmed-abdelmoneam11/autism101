import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class Educational1 extends StatelessWidget {
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
          "Educational",
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
                  "How to Homeschool Your Autistic Child",
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
                  "There's a well-known saying that goes: if you've met one child with autism, you've met one child with autism. In other words, every child with autism is unique, and every set of needs and strengths is different. That can make it surprisingly difficult for school districts attempting to create autism support programs, classrooms, or training programs. You may find that your district is unable to provide the services your child needs. When that happens, you may want to consider the possibility of homeschooling your child, at least for a period of time. The Setting Schools are required to provide free and appropriate education to all children, with goals and accommodations in place to help each child learn in the least restrictive setting. In theory, you'd think that every child should receive an ideal, personalized educational experience designed to help him achieve at his highest potential. The reality, however, is often quite different from theory. There are many reasons why public (or even private) school may not be the right setting for your particular child at a particular point in her development. Individualized Educational Programs (IEPs) are built around a student's challenges, and goals are focused on the student's deficits.1﻿ As a result, your child's education may not build on strengths or even provide opportunities to expand on her areas of interest. In addition, in order to take advantage of therapies or specialized programs, she may miss out on opportunities to participate in classes such as art, music, or gym. Schools, in general, can be a perfect storm of challenges for your autistic child. Many schools are loud, bright, crowded, and confusing. Social norms vary from moment to moment—children are expected to behave differently depending on whether they're in an academic class, the cafeteria, the gym, or the playground. Each teacher may have a unique set of expectations, rules, and schedules. The list goes on and on, and for some children, no school setting will be ideal. It's common for children with special needs to be bullied in the school setting, and children with autism are a particularly easy target. Even if your child is unaware of the whispers, stares, and sarcasm around him, it can have a devastating impact on his school career. If your child is able to be in a general education setting, she may run into challenges based on her learning style. While autistic children tend to be visual, spatial, and mathematical learners, most classes assume a verbal learning style. If your child is in an autism support classroom, he may find it stressful (many such classrooms include children with behavioral issues). He may also be higher or lower functioning that the other students in the classroom. Benefits If you are a parent who has the time, energy, money, and inclination to homeschool (and those are a lot of ifs) and you happen to live in a homeschool-friendly state, homeschooling can be a terrific option for your autistic child. Here are just some of the benefits: Targeted Learning: Parents can target learning directly to their child's interests and strengths while finding appropriate ways to help remediate challenges. For example, a child who loves trains can use trains to learn how to count, read, draw, pretend, and explore the community. Parents can also develop or find visual, video-based, or hands-on learning tools to support their child's learning style. Targeted Support: Parents can support their child appropriately in a much wider array of community settings, carefully selecting the right time and place. For example, a child might enjoy and learn from a library program if a parent is on the spot to manage any behavioral issues and help their child learn to find and check out favorite books. Tailored Experiences: Parents can seek out appropriate experiences for their child, based on his particular profile. Swim classes at the YMCA, Challenger League basketball, local video opportunities, nature hikes, museum visits, trips to the playground, and much more, can be accessed with the right preparation and support. In some cases, parents can plan to introduce new settings slowly, and prepare to leave whenever their child is ready.",
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
