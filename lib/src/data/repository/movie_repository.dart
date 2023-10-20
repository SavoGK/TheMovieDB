import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/repository/repository.dart';
import '../../core/utils/general_constants.dart';
import '../../domain/entity/movie.dart';
import '../models/movie_model.dart';

class MovieRepository implements Repository {
  static const String jsonFilePath = 'assets/data/movies.json';
  static List<MovieModel> movies = <MovieModel>[];

  Future<void> fetchData() async {
    try {
      final String jsonString = await rootBundle.loadString(jsonFilePath);
      final jsonData = jsonDecode(jsonString);

      if (jsonData is List) {
        movies = jsonData.map((json) => MovieModel.fromJson(json)).toList();
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
