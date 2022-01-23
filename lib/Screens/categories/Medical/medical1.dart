import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class Medical extends StatelessWidget {
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
                  "Diagnosing ASD",
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
                  "Doctors diagnose ASD by looking at a person’s behavior and development. ASD can usually be reliably diagnosed by the age of two. It is important for those with concerns to seek out assessment as soon as possible so that a diagnosis can be made, and treatment can begin. Diagnosis in Young Children Diagnosis in young children is often a two-stage process. Stage 1: General Developmental Screening During Well-Child Checkups Every child should receive well-child check-ups with a pediatrician or an early childhood health care provider. The American Academy of Pediatrics recommends that all children be screened for developmental delays at their 9-, 18-, and 24- or 30-month well-child visits and specifically for autism at their 18- and 24-month well-child visits. Additional screening might be needed if a child is at high risk for ASD or developmental problems. Those at high risk include children who have a family member with ASD, have some ASD behaviors, have older parents, have certain genetic conditions, or who were born at a very low birth weight. Parents’ experiences and concerns are very important in the screening process for young children. Sometimes the doctor will ask parents questions about the child’s behaviors and combine those answers with information from ASD screening tools, and with his or her observations of the child. Read more about screening instruments on the Centers for Disease Control and Prevention (CDC) website. Children who show developmental problems during this screening process will be referred for a second stage of evaluation. Stage 2: Additional Evaluation This second evaluation is with a team of doctors and other health professionals who are experienced in diagnosing ASD. This team may include: A developmental pediatrician—a doctor who has special training in child development A child psychologist and/or child psychiatrist—a doctor who has specialized training in brain development and behavior A neuropsychologist—a doctor who focuses on evaluating, diagnosing, and treating neurological, medical, and neurodevelopmental disorders A speech-language pathologist—a health professional who has special training in communication difficulties The evaluation may assess: Cognitive level or thinking skills Language abilities Age-appropriate skills needed to complete daily activities independently, such as eating, dressing, and toileting Because ASD is a complex disorder that sometimes occurs along with other illnesses or learning disorders, the comprehensive evaluation may include: Blood tests Hearing test The outcome of the evaluation will result in a formal diagnosis and recommendations for treatment.",
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
