import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
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
                "Frequently Asked Questions",
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
              'assets/images/FREQUENTLYASKEDQUESTIONS.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReadMoreText(
              "Can autism be cured? No, autism spectrum disorder (ASD) cannot be cured, but it can be treated. There are several behavioral interventions that can be very helpful in reducing symptoms and improving daily living skills in younger children. In older children and adults, there isn't enough evidence to prove the effectiveness of various behavioral and social interventions, which is why early intervention is so important.7 What are the treatment options for autism? Treatment options can include specialized therapies, medications to manage symptoms, and lifestyle modifications such as dietary approaches. Specialized therapies that may be included in an autism treatment plan include:7 Speech therapy Occupational therapy Physical therapy Social skills therapy Behavioral therapy Developmental therapy Assistive technology What happens if someone with autism doesn't seek treatment? If autism is left untreated, children may not develop effective social and communication skills and may face more challenges going through school and adult life than their peers.8 It's also possible that symptoms may worsen as children grow up—including the onset of seizures during puberty. On the other hand, people on the mild end of the spectrum may learn ways to overcome their symptoms as they grow older. Can children outgrow autism? Some research has shown that yes, children can outgrow an autism diagnosis. However, in these cases, it's more likely that children will no longer meet the criteria for an ASD diagnosis but will still possess learning difficulties and emotional and behavioral issues that need regular monitoring and treatment. What are early signs of autism? Parents and relatives should be concerned about their infant or toddler if they notice any of the following developmental delays or behavioral problems and discuss concerns with their child’s pediatrician to obtain appropriate referrals for evaluation: lack of or delay in development of spoken language . repetitive use of language and/or motor mannerisms (e.g., hand-flapping, twirling objects). little or no eye contact. lack of interest in peer relationships. lack of spontaneous or make-believe play. persistent fixation on parts of objects. What are some symptoms of autism that parents and caregivers can look for ? Children diagnosed with autism tend to process and respond to information in the environment in unique ways. In some cases, parents are frightened because they exhibit aggressive and/or self-injurious behaviors which are difficult to manage. Insistence on sameness in routines (O) Difficulty in expressing needs verbally, using gestures or pointing instead of words (C) Repeating words or phrases in place of normal, responsive language (C) Laughing (and/or crying) for no apparent reason; showing distress for reasons not apparent to others (S) Prefers to be alone; aloof manner evident to strangers and family members (S) Tantrums and low frustration tolerance (S) Difficulty in initiating social contact with others (S) Uncomfortable with physical contact even when given with affection such as a hug (S) Little or no eye contact even when spoken to directly (S) Unresponsive to normal teaching methods (S) Plays with toys as objects (example bangs a toy car as a block rather than as a moving vehicle) (S) Focus on spinning objects such as a fan or the propeller of a toy helicopter (O) Obsessive attachment to particular objects (O) Apparent over-sensitivity or under-sensitivity to pain (S) No real fears of danger despite obvious risks of harm. (S) Noticeable physical over-activity or extreme under-activity (S) Impaired fine motor and gross motor skills (S) Non-responsive to verbal instructions; often appears as if child is deaf although hearing tests in normal range (C)",
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
