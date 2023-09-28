import 'package:flutter/material.dart';
import 'models/movie.dart';
import 'widget/movie_deck.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static Movie marioBros = Movie.mockMovie();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(marioBros.originalTitle),
        ),
        body: SafeArea(
          child: Center(
            child: MovieDeck(marioBros),
          ),
        ),
      ),
    );
  }
}
