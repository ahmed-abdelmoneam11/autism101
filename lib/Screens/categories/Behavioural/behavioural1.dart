import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class Behavioural extends StatelessWidget {
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
                  "How to Help an Autistic Child Build Artistic Skills",
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
                  "When a child has an autism diagnosis, the focus is usually on helping them manage daily life as typically as possible. Behavioral and developmental therapies focus on speech, social skills, and self-regulation, while occupational and physical therapies help build skills like handwriting, throwing, and kicking. From the parents’ point of view, just getting through a normal day can be challenging. The idea of introducing artistic creativity into the mix can seem unnecessary or even overwhelming. However, research1 shows that music,2 dance, and visual art can and do improve the lives of people on the spectrum. Not only do arts therapies improve social skills and engagement, but active participation in community arts programs can enhance inclusion, self-confidence, and communication. Just as importantly, many autistic children have strong skills in artistic expression and enjoy it in its many forms. Benefits of the Arts for an Autistic Child People with autism are very different from one another. Some are not interested in the arts; others have little or no interest in technology. But for those children and teens who are intrigued by creative self-expression, music and visual art have a wide range of benefits that are hard to find anywhere else.3 Depending on the individual, just a few of those benefits include: Experience with self-expression that does not require verbal strengths: All people with autism have difficulty with verbal self-expression; many are non-verbal or nearly non-verbal. The arts provide a tool for self-expression that is accessible for someone without the means to discuss their worldview. Opportunities for social growth: Artistic activities are often communal—think of band, theater, dance groups, and art classes—and require a degree of interaction and engagement that typical classroom experiences don’t. In fact, some social skills therapists build their programs around arts activities for that very reason. Opportunities to build on strengths: From the time they are diagnosed, children with autism are judged for what they can’t do and taught to “catch up” with others. In the arts, however, children with autism often have the edge. Many are quite talented in drawing, music, and even drama. Opportunities for true inclusion: It’s difficult to fully include a child with autism in social activities or sports programs—their differences in those settings become real liabilities. In the arts, however, children with autism can often be fully included as part of a group of peers. Lifelong interests to enjoy and share: Children with autism are constantly learning new, complex skills, only to outgrow the need for them as they move through childhood and into adulthood. Social skills for kindergarteners are irrelevant to third graders, and sharing is uncool by the time a child is 11. Arts interests and skills, however, are relevant throughout the lifespan.",
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
