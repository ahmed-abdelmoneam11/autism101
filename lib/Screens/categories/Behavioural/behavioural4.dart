import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class Behavioural4 extends StatelessWidget {
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
                  "Why Your Child With Autism Echoes, Words and Sounds",
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
                  "Echolalia describes the precise repetition, or echoing aloud, of words and sounds. Echolalia can be a symptom of various disorders including aphasia, dementia, traumatic brain injury, and schizophrenia, but it is most often associated with autism. Echolalia is not always a self-calming tool, like rocking or hand-flapping. It has its own patterns and may be how your autistic child first uses speech to communicate. Thus, while it can be described as a symptom of autism, it's also a point of entry for a parent or speech-language therapist to start working with your child.1 This article explores how echolalia emerges in children (whether on the autism spectrum or not), the types of echolalia you may encounter, and how to best help an autistic child with echolalia. Echolalia in Child Development Echolalia is actually a normal part of child development: As toddlers learn to speak, they imitate the sounds they hear.2 Over time, however, a typically developing child learns language, and uses it to communicate their needs and ideas by connecting new words together. By the time they are 3 years old, most children communicate with others by selecting words or crafting phrases using their own unique voices and intonation.3 By the time they are 4 or 5, they are able to ask and answer questions, carry on conversations, and otherwise use language in their own way to communicate with others.4 Echolalia in Autism One of the difficulties in understanding echolalia in autistic children is that the repetitive echolalia speech patterns may be used for different reasons. Those purposes can change over time, and it's also possible for a person to use echolalia for multiple purposes at the same time.5 Many children with autism do use words, sometimes very complex adult words. Yet their words are, in a sense, not their own. They're said in the same order, and usually in the same tone, as those they've heard on a TV show, in a book, or from their teacher and other people. Reasons why autistic children use echolalia in speech patterns include: Self-stimulation: Often called stimming, this use of echolalia speech patterns is meant as a calming strategy. The repetition is used to cope with overwhelming sensory challenges. Prefabrication: The use of repeated phrases and scripts helps to communicate when it is too difficult or stressful for the speaker to form their own original words. Self-talk: Memorized phrases may help a child to talk themselves through a difficult process using phrases heard from parents, teachers, or television. For many children with autism, echolalia is a key first step toward more typical forms of spoken communication. For example, a child with autism may repeat a teacher's phrase, like say thank you, exactly as the teacher said it rather than actually saying the intended thank you in response. Recap Echolalia is often described as a symptom of autism, but for many children it's also the first step on a pathway toward more typical language use. Types of Echolalia There are different kinds of echolalia, and the terms can be a bit confusing if you're new to hearing them. That's partly because the understanding of echolalia changes over time. What was once considered a problem to fix, for example, is now viewed as a possible pathway for speech development. In the same way, functional echolalia is often called interactive echolalia. Other types may be described as non-interactive or mitigated, when talking about how the autistic speaker is using the pattern. Immediate and delayed describe the timing of the repetitive words.",
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
