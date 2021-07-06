import 'package:tema5/models/movie.dart';

class GetMovies {
  GetMovies(this.page);

  final int page;
}

class GetMoviesSuccessful {
  GetMoviesSuccessful(this.movies);

  final List<Movie> movies;
}

class GetMoviesError {
  GetMoviesError(this.error);

  final Object error;
}