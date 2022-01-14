import 'package:autism101/Screens/user/character_data.dart';
import 'package:autism101/Screens/user/characters_screen.dart';
import 'package:autism101/model/Movie.dart';
import 'package:flutter/material.dart';

import 'MovieScreen.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

List<Movie> movies = [
  Movie(
    'assets/images/movie1.jpg',
    'Little Man Tate',
    'A single mother raises a child prodigy on her own, struggling to give him every opportunity he needs to express his gift.',
    '15+',
    'Jodie Foster, Dianne Wiest, Dianne Wiest',
    'https://www.imdb.com/title/tt0102316/?ref_=nv_sr_srsg_3',
  ),
  //*************************************************************** */
  Movie(
    'assets/images/movie2.jpg',
    'Rain Man',
    "After a selfish L.A. yuppie learns his estranged father left a fortune to an autistic savant brother in Ohio that he didn't know existed",
    '15+',
    'Dustin Hoffman, Tom Cruise, Valeria Golino',
    'https://www.imdb.com/title/tt0095953/?ref_=vp_vi_tt',
  ),
  //****************************************************************/
  Movie(
    'assets/images/movie3.jpg',
    'I Am Sam',
    'A mentally handicapped man fights for custody of his 7-year-old daughter and in the process teaches his cold-hearted lawyer the value of love and family.',
    '13+',
    'Sean Penn, Michelle Pfeiffer, Dakota Fanning',
    'https://www.imdb.com/title/tt0277027/?ref_=vp_vi_tt',
  ),
  //****************************************************************/
  Movie(
    'assets/images/movie4.jpg',
    'X+Y',
    'A socially awkward teenage math prodigy finds new confidence and new friendships when he lands a spot on the British squad at the International Mathematics Olympiad.',
    '13+',
    'Asa Butterfield, Rafe Spall, Sally Hawkins',
    'https://www.imdb.com/title/tt3149038/?ref_=fn_al_tt_1',
  ),
  //****************************************************************/
  Movie(
    'assets/images/movie5.jpg',
    'El faro de las orcas',
    'A mother with an autistic child travel from Spain to Argentina looking to help her son to connect with his emotions.',
    '15+',
    'Maribel Verdú, Joaquín Furriel, Joaquín Rapalini',
    'https://www.imdb.com/title/tt4944658/?ref_=nv_sr_srsg_1',
  ),
  //****************************************************************/
  Movie(
    'assets/images/movie6.jpg',
    'The Horse Boy',
    'A writer documents the journey his family takes to Mongolia to consult with nomadic shamans on the healing of their autistic son.',
    'Unrated',
    'Rupert Isaacson, Kristin Neff, Rowan Isaacson',
    'https://www.imdb.com/title/tt1333668/?ref_=nv_sr_srsg_0',
  ),
  //****************************************************************/
  Movie(
    'assets/images/movie7.jpg',
    'The A Word',
    "The Hughes family work and love and fight like every other family. Then, their youngest son is diagnosed with autism and they don't feel like every other family anymore.",
    'Unrated',
    'Max Vento, Lee Ingleby, Christopher Eccleston',
    'https://www.imdb.com/title/tt5311790/?ref_=nv_sr_srsg_7',
  ),
  //****************************************************************/
  Movie(
    'assets/images/movie8.jpg',
    'A Boy Called Po',
    'After his wife dies of cancer, an overworked engineer struggles to care for his son with autism. His son in response to bullying regresses into a fantasy world escape.',
    'PG',
    'Christopher Gorham, Julian Feder, Kaitlin Doubleday',
    'https://www.imdb.com/title/tt1401621/?ref_=nv_sr_srsg_0',
  ),
  //****************************************************************/
  Movie(
    'assets/images/movie9.jpg',
    'My Name Is Khan',
    "An Indian Muslim man with Asperger's syndrome takes a challenge to speak to the President of the United States seriously and embarks on a cross-country journey.",
    '13+',
    'Shah Rukh Khan, Kajol, Sheetal Menon',
    'https://www.imdb.com/title/tt1188996/?ref_=ttmi_tt',
  ),
  //****************************************************************/
  Movie(
    'assets/images/movie10.jpeg',
    'Please Stand By',
    'A young autistic woman runs away from her caregiver in an attempt to submit her 500-page manuscript to a "Star Trek" writing competition at Paramount Pictures.',
    '13+',
    'Dakota Fanning, Alice Eve, Toni Collette',
    'https://www.imdb.com/title/tt4652650/?ref_=nv_sr_srsg_0',
  ),
  //****************************************************************/
  Movie(
    'assets/images/movie11.jpeg',
    'Snow Cake',
    'A drama focused on the friendship between a high-functioning autistic woman and a man who is traumatized after a fatal car accident.',
    'Unrated',
    'Alan Rickman, Sigourney Weaver, Carrie-Anne Moss',
    'https://www.imdb.com/title/tt0448124/?ref_=nv_sr_srsg_0',
  ),
  //****************************************************************/
  Movie(
    'assets/images/movie12.jpeg',
    'The Accountant',
    'As a math savant uncooks the books for a new client, the Treasury Department closes in on his activities, and the body count starts to rise.',
    'R',
    'Ben Affleck, Anna Kendrick, J.K. Simmons',
    'https://www.imdb.com/title/tt2140479/?ref_=nv_sr_srsg_0',
  ),
];

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Movies',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
      ),
      body: Container(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20),
            padding: EdgeInsets.all(10),
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieScreen(movie: movies[index]),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 0.5, //extend the shadow
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(movies[index].image),
                        fit: BoxFit.cover),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
