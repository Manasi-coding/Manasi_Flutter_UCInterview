import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'movie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> 
{

  Movie? movie;
  bool isLoading = false;
  String? error;

  //Future - fetches api
    Future<void> fetchRandomMovie() async {
    setState(() => isLoading = true);

    final url = Uri.parse('https://flutterucinterviewtask.onrender.com/random');
    final response = await http.get(url);

    if (response.statusCode == 200) //success code
    {
      final data = json.decode(response.body);
      setState(() {
        movie = Movie.fromJson(data);
        isLoading = false;
      });
    } 
    else {
      print('ERROR!');
      setState(() => isLoading = false);
    }
  }


  //building the widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: movie != null ? _buildMovieCard(movie!) : SizedBox.shrink(),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,   //stretch
                height: 50.0,
                child: TextButton(
                  onPressed: fetchRandomMovie, 
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFA4DA7D)
                  ),
                  child: Text(
                    'Shuffle',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  )
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //helper method no 1
  Widget _buildMovieCard(Movie movie)   //_ makes it private (encapsulation)
  {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFf1faee),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView(
        children: [
          //Movie Title
          Text(
            movie.title,
            style: TextStyle(
              color: Colors.white,
            )
          ),
          SizedBox(height: 8.0),

          //Image (rounded rectangle)
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              movie.poster,
              width: double.infinity,
              height: 100.0,
              fit: BoxFit.cover,
            )
          ),
          SizedBox(height: 8.0),

          //year,runtime,rated
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _infoText(movie.year),
              _infoText(movie.runtime),
              _infoText(movie.rated),
            ],
          ),
          SizedBox(height: 8.0),

          //those little round boxes
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: movie.genre.split(', ').map((g){
              return Chip(    //A Chip is a small rounded UI
                label: Text(
                  g,
                  style: TextStyle(
                    color: Color(0xFF6a994e),
                    fontSize: 12.0,
                  ), 
                ),
                backgroundColor: Color(0xFF6a994e),
              );
            }).toList(),
          ),
          SizedBox(height: 8.0),

          //stars
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.star, color: Color(0xFF6a994e), size: 18.0),
              SizedBox(width: 4.0),
              Text(
                '${movie.imdbRating}/10',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 4.0),
              Text(
                '(${movie.imdbVotes} votes)',
                style: TextStyle(color: Color(0xFF6a994e)),
              ),
            ],
          ),
          SizedBox(height: 8.0),

          //Director
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.person, color: Color(0xFF6a994e), size: 18.0),
              SizedBox(width: 4.0),
              Text(
                'Director: ',
                style: TextStyle(color: Color(0xFF6a994e)),
              ),
              Text(
                movie.director,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(height: 8.0),

          //Writers
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.receipt, color: Color(0xFF6a994e), size: 18.0),
              SizedBox(width: 4.0),
              Expanded(
                child: Wrap(
                  children: [
                    Text(
                      'Writers: ',
                      style: TextStyle(color: Color(0xFF6a994e)),
                    ),
                    Text(
                      movie.writers,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              )
            ],
          ),
          SizedBox(height: 8.0),

          //Summary
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              movie.plot,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 14.0),

          //Language
          Row(
            children: [
              Icon(Icons.language, color: Color(0xFF6a994e), size: 18.0),
              SizedBox(width: 4.0),
              Text(
                'Language: ',
                style: TextStyle(color: Color(0xFF6a994e)),
              ),
              Text(
                movie.language,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(height: 8.0),

          //Country
          Row(
            children: [
              Icon(Icons.public, color: Color(0xFF6a994e), size: 18.0),
              SizedBox(width: 4.0),
              Text(
                'Country: ',
                style: TextStyle(color: Color(0xFF6a994e)),
              ),
              Text(
                movie.country,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(height: 8.0),

          //Awards
          Row(
            children: [
              Icon(Icons.emoji_events, color: Color(0xFF6a994e), size: 18.0),
              SizedBox(width: 4.0),
              Text(
                'Awards: ',
                style: TextStyle(color: Color(0xFF6a994e)),
              ),
              Text(
                movie.awards,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }

  //helper method no 2
  Widget _infoText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFFccff33), 
        fontSize: 13,
      )
    );
  }
}

