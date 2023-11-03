class FontConst {
  static const double fontTitle = 20;
  static const double fontSubTitle = 16;
  static const double fontText = 15;
}

class EdgeInsetsConst {
  static const double marginSmall = 8;
  static const double marginMedium = 10;
}

class BordersConst {
  static const double borderCircular = 80;
}

class AppName {
  static const String name = 'Peliculero';
}

class RepositoryStrings {
  static const String errorLoading = 'Error loading JSON data: ';
  static const String errorFormat = 'JSON data is not in the expected format.';
}

class FutureConst {
  static const String error = 'Error: ';
  static const String state = 'State: ';
  static const int positionZero = 0;
}

class TitleStrings {
  static const String genders = 'Genders';
}

class ApiServiceConst {
  static const String urlImages = 'https://image.tmdb.org/t/p/original';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer ';
  static const String nowPlaying = '/movie/now_playing';
  static const String popular = '/movie/popular';
  static const String topRated = '/movie/top_rated';
  static const String upcoming = '/movie/upcoming';
  static const String movie = '/discover/movie';
  static const String urlMovie = 'https://api.themoviedb.org/3';
  static const String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNzA2YjExZjlmMDNmYWE1M2Y1YTVkZGM3ZWM0NTU'
      'xZCIsInN1YiI6IjY1MzY2YWE4YzE0ZmVlMDBlMzVmYjRiZCIsInNjb3BlcyI6WyJhcGlfcmV'
      'hZCJdLCJ2ZXJzaW9uIjoxfQ.xNqVxoM-ribNnQbHvonSPHDEVMXvRp_PajwUDzX6mtY';
  static const String apiErrorMessage =
      'An error occurred while trying to get the data.';
}
