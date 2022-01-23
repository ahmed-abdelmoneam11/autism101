import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class Behavioural3 extends StatelessWidget {
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
                  "What Is Applied Behavioral Analysis (ABA) Therapy for Autism?",
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
                  "Applied behavior analysis (ABA) is a type of therapy that teaches skills and proper behavior through reinforcement. It's commonly described as the gold standard for autism treatment. Many people are advocates of ABA because of its success in helping individuals with autism learn behaviors and skills. Others believe it's too hard on kids and forces them to conform to others' ideas of normal behavior. What Is ABA Therapy? ABA is a type of therapy for autism that helps reinforce desired behaviors and discourage unwanted behavior. To do this, therapists use rewards to encourage communication, language, and other skills. There are several different types of ABA, depending on the patient's age and goals for therapy. It was created in the 1960s by psychologist Dr. Ivar Lovaas, but the methods used have evolved over the years. History Dr. Ivar Lovaas, a behavioral psychologist, first applied ABA to autism. He believed that social and behavioral skills could be taught to children with autism. His idea was that autism is a set of behavioral symptoms that can be modified or extinguished. When autistic behaviors were no longer evident, it was assumed that the autism had been effectively treated. Back then, ABA also included punishments for non-compliance, some of which could be very harsh, including electric shocks. Today, punishments aren't used in ABA and are considered morally unacceptable. In general, punishment has been replaced by withholding of rewards. For example, a child who does not properly respond to a mand (command) will not receive a reward such as a favorite food. Over time, Lovaas's technique, also called discreet trial training, has been studied and modified by therapists. Today, therapists aren't looking to cure autism but to help patients learn to live fully and independently. Techniques not only focus on behavior but social and emotional skills as well.1 Recap ABA therapy was first started by Dr. Ivar Lovaas, a behavioral psychologist. The therapy has evolved over the years, eliminating punishments and focusing on rewards for desired behavior. Types of ABA Strategies Therapists may use different methods of ABA. Some examples of ABA strategies include: Discrete Trial Training: Lovaas's technique breaks down lessons into simple tasks. Each task is rewarded with positive reinforcement for correct behavior. Early Start Denver Model: For kids ages 12 to 48 months, this therapy includes play and joint activities to help kids with language, cognitive, and social skills. Pivotal Response Training: The main goals are for children to start conversations with others, increase their motivation to learn, and monitor their own behavior. Early Intensive Behavioral Intervention: For children who are younger than 5 years old, this therapy helps build positive behavior and reduce unwanted behavior. Therapy sessions are one-on-one with a trained therapist.",
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
