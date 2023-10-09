import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'repository.dart';
import '../../utils/general_constants.dart';
import '../movie.dart';

class MovieRepository implements Repository {
  static const String jsonFilePath = 'data/movies.json';
  static List<Movie> movies = [];

  Future<void> fetchData() async {
    try {
      final jsonString = await rootBundle.loadString(jsonFilePath);
      final jsonData = jsonDecode(jsonString);

      if (jsonData is List) {
        movies = jsonData.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw const FormatException(RepositoryStrings.errorFormat);
      }
    } catch (e) {
      print('${RepositoryStrings.errorLoading} $e');
    }
  }

  @override
  Future<List<Movie>> getData() async {
    if (movies.isEmpty) {
      await fetchData();
    }
    return movies;
  }
}
