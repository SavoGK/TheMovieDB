import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:the_movie_db/utils/general_constants.dart';
import '../genre.dart';
import 'repository.dart';

class GenreRepository implements Repository {
  static const String jsonFilePath = 'data/genres.json';
  static List<Genre> genres = [];

  Future<void> _fetchData() async {
    try {
      final jsonString = await rootBundle.loadString(jsonFilePath);
      final jsonData = jsonDecode(jsonString);
      final genresList = jsonData["genres"];

      if (genresList is List) {
        genres = genresList.map((json) => Genre.fromJson(json)).toList();
      } else {
        throw const FormatException(RepositoryStrings.errorFormat);
      }
    } catch (e) {
      print('${RepositoryStrings.errorLoading} $e');
    }
  }

  @override
  Future<List<Genre>> getData() async {
    if (genres.isEmpty) {
      await _fetchData();
    }
    return genres;
  }
}
