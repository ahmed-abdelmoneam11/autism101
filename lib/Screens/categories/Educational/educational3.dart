import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class Educational3 extends StatelessWidget {
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
                  "Sending an Autistic Child to Public School",
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
                  "Pros and Cons Parents Should Consider Public schools are required to provide free education to all American children, and most children with autism do attend public school. In some cases, a public school can provide appropriate educational and social settings for your autistic child. However, in many cases, your local public school will struggle to find an appropriate setting and provide a meaningful educational program. Is public school likely to be a good match for your child? It all depends on your child, your school district, your expectations, and your budget. Teaching Approaches Depending on your child's needs and abilities, your child will probably wind up in one or another of these settings: Typical public school classroom without special support (mainstreaming) Typical public school classroom with support (1-to-1 and/or adaptations) Part-time typical classroom, part-time special needs classroom setting General special needs class Specialized public autism class with some inclusion or mainstreaming Specialized public autism class without inclusion or mainstreaming Charter School Cyber charter school Most children with autism will receive some kind of therapy (usually speech, occupational, and/or physical therapy) in addition to their academic programs. If a child is academically capable, they will be  aught the same curriculum as his typical peers. If the child has moderate intellectual, learning, or attention challenges, they may be taught in slower classes or in a resource room. If there are more severe symptoms, the program may consist almost entirely of behavioral (rather than academic) education. Pros There are great advantages to a public education for a child on the autism spectrum. Right off the bat, public school is free. Because of the Individuals with Disabilities Education Act (IDEA), there's much more to a public school education than academics. According to the IDEA, a child with autism must receive a Free and Appropriate Public Education (FAPE) in the Least Restrictive Environment (LRE). That means that your child must receive the right supports to be at least moderately successful in a typical educational setting.1﻿﻿ Each autistic child in public school must have an Individualized Educational Plan (IEP). In it, you and your child's district-level team will layout a plan and benchmarks based on your child's goals and special needs. If your child isn't progressing as expected, you or your team members can call a meeting to decide what to do next. If your child does thrive in a general education setting, public school is a great way to connect more fully will new friends, other parents, and the school community as a whole. Cons The principle of the public school model may sound ideal for some parents. But of course, nothing is as good as ever as good as it sounds. Parents will often hear school administrators citing budgetary and administrative constraints that limit their ability to enact certain plans or achieve certain goals. In practice, this means that a child with autism is most likely to get an adequate education based on someone else's definition of moderately successful. There are different ways this can play out.",
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
