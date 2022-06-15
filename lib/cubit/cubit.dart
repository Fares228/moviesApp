import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/cubit/states.dart';

import '../models/genres_model.dart';
import '../models/movie_model.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(MovieLoadingState());

  final Dio _dio = Dio();

  Genre? firstGenre;

  Future<void> getCategories() async {
    final result = await _dio.get('https://api.themoviedb.org/3/genre/movie/list?api_key=2001486a0f63e9e4ef9c4da157ef37cd');
    final genres = (result.data['genres'] as List).map((e) => Genre.fromJson(e)).toList();
    firstGenre = genres.first;
    final movies = await getMoviesByGenres();
    emit(MovieScreenSuccessState(
        movies: movies,
        genres: genres
    ));
  }

  Future<List<MovieDetails>> getMoviesByGenres([bool emitLoading = false]) async {
    try {
      List<Genre> categories = [];
      if (state is MovieScreenSuccessState) {
        categories = (state as MovieScreenSuccessState).genres;
      }
      if (emitLoading) {
        emit(MovieLoadingState());
      }
      final result = await _dio.get('https://api.themoviedb.org/3/discover/movie?with_genres=${firstGenre!.id}&api_key=2001486a0f63e9e4ef9c4da157ef37cd');
      final movies = (result.data['results'] as List).map((e) => MovieDetails.fromJson(e)).toList();
      if (emitLoading) {
        emit(MovieScreenSuccessState(movies: movies, genres: categories));
      }
      return movies;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

}