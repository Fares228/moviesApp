import '../models/genres_model.dart';
import '../models/movie_model.dart';

abstract class MovieStates {}

class MovieLoadingState extends MovieStates {}

class MovieScreenSuccessState extends MovieStates {
  final List<Genre> genres;
  final List<MovieDetails> movies;
  MovieScreenSuccessState({required this.movies, required this.genres});
}

class MovieErrorState extends MovieStates {}