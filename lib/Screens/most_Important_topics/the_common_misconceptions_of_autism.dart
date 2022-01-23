import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:autism101/Constants.dart';

class TheCommonMisconceptionsOfAutism extends StatelessWidget {
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
                "The Common Misconceptions Of Autism",
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
              'assets/images/TheCommonMisconceptionsOfAutism.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReadMoreText(
              "Unfortunately, some commonly held beliefs about Autism, which we know to be untrue, persist. This lack of understanding can make it difficult for people on the Autism Spectrum to have their condition recognised and to access the support they need. Misconceptions can lead to some people with Autism feeling isolated and alone. Myths such as, All people with Autism have an outstanding ‘savant’ skill” or “Children with Autism don’t speak are explored below. Myth: All people with Autism have the same skills and difficulties The facts: Although people with Autism share difficulties in the core areas of social-communication, restricted and repetitive behaviours and sensory processing, every person with Autism is unique and has different abilities and interests. This is why Autism is called a ‘spectrum disorder’, and why supports should be tailored to the person’s individual needs. Myth: All people with Autism have an outstanding 'savant' skill The facts: People with Autism generally have an uneven developmental profile, meaning that their level of ability may vary across different skills and even within the same skill area.  Some people with Autism do indeed have an exceptional ability far above that of the general population (also called a ‘savant skill’). Still, research tells us that more than two-thirds of people with Autism don’t. So, even though savant skills – like having a photographic memory, or the ability to compute complex mathematical equations quickly – and Autism may be linked in some way, most people with Autism do not in fact have a savant skill.  Everyone has strengths, and the best way to learn about someone’s strengths is by getting to know who they are as a person and what they love.  Myth: People with Autism do not have other disorders or conditions The facts: Although many people with Autism do not have other conditions, many do. Some common conditions that may co-occur with Autism (also known as ‘comorbidity’) include: Intellectual Disability or Developmental Delays Seizures and Epilepsy Fragile X Syndrome Tuberous Sclerosis Anxiety Gastro-intestinal problems Feeding issues Disrupted sleep Motor Difficulties Comorbid conditions can appear at any time during a person’s life. Some may be present from birth or in childhood, while others might only appear later in adolescence or adulthood. It is important to identify co-occurring conditions and seek appropriate treatment for them as some of the symptoms may affect how well Autism strategies and therapies work. Myth: All people with Autism have an intellectual disability The facts: Some people with Autism also have an Intellectual Disability, however others have an Intelligence Quotient (IQ) within the typical range or higher. Estimated rates of intellectual disability in Autism vary widely and are influenced by the intelligence tests used and the samples of people involved. In some cases a measure of IQ is taken during the initial Autism assessment process. Determining IQ in children can be more difficult, and an accurate measure may not always be possible. It is essential not to restrict a person’s opportunities for education and social interactions by making assumptions about their intellectual abilities. Myth: Children with Autism do not speak The facts: Although some children with Autism may have delayed speech or may not use words to communicate, many have very well developed speech. In fact, some children may speak earlier than their typically developing peers but may have an unusual style of communication (such as overly formal speech or a strong preference to talk about particular subjects). It is important to note that there is a very wide range of skills",
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
