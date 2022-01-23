import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class Educational2 extends StatelessWidget {
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
                  "Private Schools for Children with Autism",
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
                  "Finding the best school for a child with autistic spectrum disorder (ASD) is not always easy. While there are public schools that can meet the needs of some kids with autism, most have significant limitations. Private schools that serve autistic children, on the other hand, may have the resources necessary to both nurture a child's strengths and address their challenges. If you think a private school might be the right place for your child, here's what to know about the various options, and the pros and cons of each. Traditional Private Schools Private schools that largely serve neurotypical kids usually offer smaller class sizes than do pubic schools, individualized teaching, and some flexibility in terms of curriculum and teaching philosophy. Some, for example, may focus on hands-on learning and child-directed education, which may be better for an autistic child than verbally-based education. However, unlike public schools, these schools are not obligated to accept kids with special needs, and not all hire teachers who have been trained to working with children with special needs. A traditional private school may accept a kindergartner with high-functioning autism and then decide that they can't accommodate them after all. Special Needs Private Schools The majority of special needs (sometimes called special education) private schools serve children with learning disabilities, such as dyslexia, or executive-functioning issues like attention deficit/hyperactivity disorder (ADHD). In some cases these schools accept children with high-functioning autism as well. If you can find a special needs private school for your child, it may work out very well for them socially as, often, children with special needs are more tolerant of differences among their peers. What's more, the same supports that make education easier for a child with ADHD, say, may also be appropriate for a child with high-functioning autism. Furthermore, schools for kids with special needs are likely to adapt extracurricular activities such as music, theater, and sports to make it possible for studies of all abilities to participate in them. How Rules and Discipline Can Benefit an Autistic Child Private Schools Specializing in Autism There are also private schools intended specifically for children on the autism spectrum. In addtion to academics, these schools build in full-day therapeutic intervention including speech, occupational, and physical therapy. Autism-only schools usually serve both high- and low-functioning children, and young people may feel at home in a school for children like them. They may find true friends, supportive and understanding teachers, and opportunities to thrive in new ways. These schools are often set up based on a specific therapeutic philosophy. For example, some private schools for children with ASD spend the majority of the day implementing behavioral interventions, such as applied behavior analysis (ABA) therapy. Others focus on relationship development intervention (RDI), while others use teaching approaches such as Floortime or TEACCH. Children who are more profoundly autistic will find highly-trained specialists with the time, energy, and commitment to providing intensive, caring 1:1 intervention. A potential downside to a school specifically for children with autism is that it is a world unto itself. Because every facet of school is focused on autism, there may be few opportunities to develop real-world coping skills. Paying for Private Education Private school is expensive, making cost a potential obstacle for many families. Typical private schools cost in the vicinity of 20,000 dollars per year and specialized private schools can run 50,000 dollars or more per year. While most schools offer scholarships, the majority of families will have to be able to foot the bill themselves. If expense is a roadblock for you, it may be possible to have your local school district cover your child's tuition for a special-needs or autism-specific private school. Given funding tuition for just two or three children can set a district back more than 100,000 dollars, though, be prepared to jump through quite a few hoops. You’ll need to prove to the school district that there is no public school that can meet your child’s needs, for example. This can take a lot of time, energy, and dedication, but it may be worth it if you feel strongly that your child requires what only a private school can offer. Finally, keep in mind that because there are comparatively few private schools that cater to children with autism, it is not uncommon to have a long commute back and forth. Private schools typically do not arrange for or cover the costs of school buses, and parents generally have to pay for bus companies themselves.",
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
