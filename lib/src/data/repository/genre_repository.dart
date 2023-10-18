import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../core/utils/general_constants.dart';
import '../models/genre.dart';
import '../../domain/repository/repository.dart';

class GenreRepository implements Repository {
  static const String jsonFilePath = 'data/genres.json';
  static List<Genre> genres = <Genre>[];

  Future<void> _fetchData() async {
    try {
      final String jsonString = await rootBundle.loadString(jsonFilePath);
      final jsonData = jsonDecode(jsonString);
      final genresList = jsonData['genres'];

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
